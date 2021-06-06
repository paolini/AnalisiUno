import sys
from plasTeX.TeX import TeX
from plasTeX.Renderers.XHTML import Renderer
tex = TeX(myfile="PlasTex.tex")
print(tex)
parse = tex.parse()
print(parse)
renderer = Renderer()
help(renderer)
print(renderer)
renderer.render(parse)
