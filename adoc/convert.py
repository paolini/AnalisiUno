import re
import subprocess
import os

chaps = [
        '00-introduzione',
        '01-reali',
        '02-successioni',
        '03-serie',
        '04-complessi',
        '05-derivate',
        '06-integrali',
        '07-spazi',
        '08-ricorrenza',
        '09-edo',
        '98-algebra',
        '99-appendix',
    ]

def main():
    for chap in chaps:
        print(chap)
        subprocess.run([
            "pandoc",
            "--katex",
            "../chapters/AnalisiUno-{}.tex".format(chap),
            "--to",
            "asciidoc",
            "--output",
            "chap-{}.adoc".format(chap)
        ])
        #convert("chapters/AnalisiUno-{}.tex".format(chap) , "xml/chap-{}.xml".format(chap))
    subprocess.run([
        'asciidoctor',
        'index.adoc'
    ])

if __name__ == "__main__":
    main()

