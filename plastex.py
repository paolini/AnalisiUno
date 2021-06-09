import sys
assert sys.version_info[0] >= 3, "python 3 required"
from plasTeX.TeX import TeX
#from plasTeX.Renderers.XHTML import Renderer
import string
from plasTeX.Renderers import Renderer


class MyRenderer(Renderer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def default(self, node):
        """ Rendering method for all non-text nodes """
        if hasattr(self, node.nodeName):
            return getattr(self, node.nodeName)(node)
        s = []

        # Handle characters like \&, \$, \%, etc.
        if len(node.nodeName) == 1 and node.nodeName not in string.ascii_letters:
            return self.textDefault(node.nodeName)

        # Start tag
        s.append('<%s>' % node.nodeName)

        # See if we have any attributes to render
        if node.hasAttributes():
            s.append('<attributes>')
            for key, value in node.attributes.items():
                # If the key is 'self', don't render it
                # these nodes are the same as the child nodes
                if key == 'self':
                    continue
                s.append('<%s>%s</%s>' % (key, str(value), key))
            s.append('</attributes>')

        # Invoke rendering on child nodes
        s.append(str(node))

        # End tag
        s.append('</%s>' % node.nodeName)

        return u'\n'.join(s)

    def document(self, node):
        return "<html><body>{}</body></html>".format(node)        

    def par(self, node):
        return "<p>{}</p>".format(node)

    def textDefault(self, node):
        """ Rendering method for all text nodes """
        return node.replace('&','&amp;').replace('<','&lt;').replace('>','&gt;')

def main():
    tex = TeX(myfile="PlasTex.tex")
    outfile = 'test.html'
    print('outfile: ', outfile)
    tex.ownerDocument.config['files']['split-level'] = -100
    tex.ownerDocument.config['files']['filename'] = outfile

    print("tex: ", tex)
    parse = tex.parse()
    print("parse: ", parse)
    renderer = MyRenderer()
    # help(renderer)
    print("renderer: ", renderer)
    render = renderer.render(parse)
    print("render: ", render)

if __name__ == '__main__':
    main()