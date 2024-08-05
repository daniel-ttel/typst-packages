#import "/Template/page.typ": *

#let shows(doc) = [
  
  #show figure.caption: it => [
    #box(width: 80%,[
      #it.supplement
      #context it.counter.display(it.numbering)#it.separator#it.body]
    )
  
  ]
  #show figure.caption: set text(9pt)
  
  #show: super-T-as-transpose
  #show: thmrules
  #metro-setup(per-mode: "symbol")
  #metro-setup(output-decimal-marker: ",")
  #metro-setup(exponent-mode: "threshold", exponent-thresholds: (-4, 4))
  #declare-unit("parsec", "pc")
  #declare-unit("atm", "atm")
  #doc
  ]

#let fin(doc) = [
  #pagebreak()
  #set heading(numbering: none)
  #show heading.where(level: 3): set heading(outlined: false)
  #doc
]
