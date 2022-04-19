import re

stack = []

def my_replace(m, line, replace):
    return line[:m.start()] + replace + line[m.end():]

def convert_line(line):
    line = re.compile(r'^\%(.*)').sub(r'<!-- \1 -->', line)
    line = re.compile(r'\\chapter{(.*?)}').sub(r'<h1 class="chapter">\1</h1>', line)
    line = re.compile(r'\\section{(.*?)}').sub(r'<h2 class="section">\1</h2>', line)
    line = re.compile(r'\\emph{(.*?)}').sub(r'<emph>\1</emph>', line)
    line = re.compile(r'\\myemph{(.*?)}').sub(r'<emph class="myemph">\1</myemph>', line)
    line = re.compile(r'\\myemph\[(.*?)\]{(.*?)}').sub(r'<emph class="myemph" margin="\1">\2</emph>', line)
    line = re.compile(r'\\label{(.*?)}').sub(r'<a name="\1" />', line)
    line = re.compile(r'\\ref{(.*?)}').sub(r'<a href="#\1">\1</a>', line)

    m = re.search(r'\\begin{(.*?)}', line)
    if m:
        env = m[1]
        stack.append(env)
        line = my_replace(m, line, '<div class="{}">'.format(env))

    m = re.search(r'\\end{(.*?)}', line) 
    if m:
        env = m[1]
        assert(stack and stack[-1] == env), "stack error while popping {} from {}".format(env, stack)
        stack.pop()
        line = my_replace(m, line, '</div>')

    line = re.compile(r'``').sub(r'&ldquo;', line)
    line = re.compile(r"''").sub(r'&rdquo;', line)
    return line

def convert(filename_in, filename_out):
    print("converting {} => {}".format(filename_in, filename_out))
    buffer = ""
    line_count = 0
    with open(filename_in) as file_in:
        try:
            for line in file_in:
                line_count += 1
                buffer += convert_line(line)
        except Exception as e:
            print("file {} line {}:".format(filename_in, line_count))
            raise e
    with open(filename_out, "w") as file_out:
        file_out.write(buffer)

def main():
    for chap in [
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
    ]:
        convert("chapters/AnalisiUno-{}.tex".format(chap) , "xml/chap-{}.xml".format(chap))


if __name__ == "__main__":
    main()

