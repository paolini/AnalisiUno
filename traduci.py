import os
import re
import sys
import textwrap
from openai import OpenAI
from dotenv import load_dotenv
load_dotenv()  # Carica le variabili dal file .env
client = OpenAI()

# CONFIGURAZIONE
INPUT_DIR = "./chapters"
MODEL_NAME = "gpt-4o"



SYSTEM_PROMPT = """
Sei un traduttore madrelingua inglese specializzato in matematica accademica e sintassi LaTeX.
Traduci il testo italiano fornito in inglese accademico chiaro, rigoroso e formale (stile analisi matematica).

REGOLE TASSATIVE:
1. NON modificare o tradurre comandi LaTeX, macro, etichette o riferimenti (es. \\ref{...}, \\label{...}, \\cite{...}, \\newcommand).
2. Mantieni INALTERATE tutte le formule matematiche ($...$, $$...$$, \\begin{equation}...\\end{equation}).
3. Traduci il testo dei titoli (\\chapter, \\section, \\subsection), gli enunciati di teoremi, definizioni, lemmi e le dimostrazioni.
4. Mantieni i nomi dei comandi degli ambienti standard.
5. Restituisci ESCLUSIVAMENTE il codice LaTeX tradotto, senza formattazione Markdown (no ```latex).
"""

def translate_file_content(content: str) -> str:
    """Traduce l'intero contenuto del file in un'unica chiamata API."""
    if not content.strip():
        return content

    try:
        response = client.chat.completions.create(
            model=MODEL_NAME,
            temperature=0.1,  # Bassa per preservare rigorosamente il codice
            messages=[
                {"role": "system", "content": SYSTEM_PROMPT},
                {"role": "user", "content": content}
            ]
        )
        translated = response.choices[0].message.content.strip()
        
        # Pulizia di sicurezza da eventuali blocchi di codice markdown restituiti dall'LLM
        # translated = re.sub(r'^```latex\n?', '', translated)
        # translated = re.sub(r'^```\n?', '', translated)
        # translated = re.sub(r'\n?```$', '', translated)
        


        return translated
    except Exception as e:
        print(f"   [ERRORE API]: {e}")
        return None

def format_latex_80_cols(text: str, max_width: int = 80) -> str:
    """
    Riformatta il testo LaTeX affinché non superi max_width colonne,
    preservando righe speciali (ambiente equation, figure, sezioni, ecc.).
    """
    lines = text.splitlines()
    formatted_lines = []
    
    for line in lines:
        # Non spezzare righe corte, comandi di sezione, ambienti o formule display
        strip_line = line.strip()
        if (len(line) <= max_width or 
            strip_line.startswith("\\") or 
            strip_line.startswith("%") or 
            "$$" in line or 
            "\\begin" in line or 
            "\\end" in line):
            formatted_lines.append(line)
        else:
            # Preserva l'indentazione iniziale se presente (es. nei listati)
            indent = line[:len(line) - len(line.lstrip())]
            wrapped = textwrap.fill(
                line, 
                width=max_width, 
                initial_indent=indent, 
                subsequent_indent=indent,
                break_long_words=False,
                break_on_hyphens=False
            )
            formatted_lines.append(wrapped)
            
    return "\n".join(formatted_lines)

def translated_filename(original_filename: str) -> str:
    """Restituisce il nome del file tradotto aggiungendo '_en' prima dell'estensione."""
    base_name, ext = os.path.splitext(original_filename)
    return f"{base_name}_en{ext}"

def process_file(input_path: str):
    """Gestisce la lettura, traduzione e salvataggio del file _en.tex"""

    output_path = translated_filename(input_path)

    print(f"Traduzione di: {input_path}")
    
    try:
        with open(input_path, "r", encoding="utf-8") as f:
            content = f.read()

        translated_content = translate_file_content(content)

        if translated_content:
            formatted_content = format_latex_80_cols(translated_content, max_width=80)

            with open(output_path, "w", encoding="utf-8") as f:
                f.write(formatted_content)
            print(f" OK -> Salvato: {output_path}\n")
        else:
            print(f" SKIP -> Saltato per errore su: {input_path}\n")
            
    except Exception as e:
        print(f" Errore nella lettura del file {input_path}: {e}\n")

def collect_tex_files(paths: list[str]) -> list[str]:
    """Raccoglie ricorsivamente tutti i file .tex validi dagli argomenti passati."""
    files_to_process = []

    def add_file_or_directory(path: str):
        if os.path.isfile(path):
            if path.endswith(".tex") and not path.endswith("_en.tex"):
                translated_path = translated_filename(path)
                if not os.path.isfile(translated_path):
                    files_to_process.append(path)
                else:
                    print(f"[SKIP] File già tradotto: {translated_path}")
        elif os.path.isdir(path):
            for root, _, files in os.walk(path):
                for file in files:
                    add_file_or_directory(os.path.join(root, file))
        else:
            print(f"[AVVISO] Percorso non valido ignorato: {path}")

    for path in paths:
        add_file_or_directory(path)
                
    return sorted(list(set(files_to_process)))

def main():
    if len(sys.argv) < 2:
        print("Uso: python traduci.py <file_o_cartella_1> <file_o_cartella_2> ...")
        print("\nEsempi:")
        print("  python traduci.py chapters/05_integrali/01_misura.tex")
        print("  python traduci.py chapters/05_integrali chapters/02_limiti")
        sys.exit(1)

    # Prende tutti gli argomenti passati da riga di comando
    input_args = sys.argv[1:]
    files = collect_tex_files(input_args)

    if not files:
        print("Nessun file .tex valido trovato negli argomenti forniti.")
        return

    print(f"Trovati {len(files)} file .tex da tradurre.\n")
    
    for file_path in files:
        process_file(file_path)

if __name__ == "__main__":
    main()