#import "toc.typ": *
#import "@preview/cetz:0.2.2": *
#import "@preview/metro:0.2.0": *
#import "@preview/modpattern:0.1.0"
#import "@preview/physica:0.9.3": *
#import "@preview/ctheorems:1.1.2": *

#let darkgreen = rgb(1, 126, 93)
#let softgreen = rgb(11,175,140)

#let conf(
  titulo: "Título del documento",
  subtitulo: "Subtítulo del documento",
  autor: "Daniel Lobos Aguayo",
  fuente_serif: "Linux Libertine",
  fuente_sans: "Inter",
  tamaño_fuente: 11pt,
  color_dest: softgreen,
  fecha: datetime.today().display("[day]/[month]/[year]"),
  doc) = {

  set text(size: tamaño_fuente, lang: "es")
  
  // Definición del header (título a la derecha, salvo primera página)
  let header = [
    #locate(loc => if [#loc.page()] == [1] {
                []
            } else {
                [
                #set text(9pt, gray)
                #h(1fr) #emph(titulo)

                ]
            }
        )
  ]
          

  // Definición del footer (número al centro, salvo la última página)
  let footer = [
    #locate(loc => if [#loc.page()] == [#counter(page).final(loc).at(0)] {
                []
            } else {
                [
                #set align(center)
                #set text(9pt, gray)
                #counter(page).display()
                ]
            }
        )
  ]

  // Formato del título
  let title = align(center)[
    #grid(row-gutter: 11pt,
      text(20pt, fill: color_dest, font: fuente_sans, strong(titulo)),
      text(14pt, font: fuente_serif, fill: gray, emph(subtitulo)),
      text(tamaño_fuente - 2pt, font: fuente_serif, emph("Apuntes de ") + autor),
      v(-.5cm),
      text(tamaño_fuente - 2pt, fecha),
      v(1cm)
    )
  ]

  // Títulos
  set heading(
    numbering: "1."
  )

  show heading.where(
          level: 2
        ): it => {
          set text(font: fuente_sans, black, size: 12pt)
          it
        }

  show heading.where(level: 3
      ): it => {
        set text(font: fuente_sans, black, size: 10pt)
        [
          #block(it.body)
        ]
      }
  
  show heading: it => {
      set text(font: fuente_sans, color_dest)
      it
    }

  // Formato de párrafos
  set par(
    justify: true,
    leading: .5em,
    first-line-indent: 0em,
    linebreaks: "optimized"
  )

  // Formato de etiquetas
  set ref(supplement: it => [])

  // Formato de listas
  set enum(
     full: true, // necessary to receive all numbers at once, so we can know which level we are at
     numbering: (..nums) => {
       let nums = nums.pos()  // just positional args
       let num = nums.last()  // just the current level’s number
       let level = nums.len()  // level is the amount of numbers available
  
       // format for current level (or stop at i. If going too deep)
       let format = ("1)", "a)", "i)").at(calc.min(2, level - 1))
       let result = numbering(format, num) // formatted number
       strong(result)
    },)

  // Formato de ecuaciones
  //set math.equation(numbering: "(1)", number-align: end + bottom)

  show heading.where(level:1): it => {
    counter(math.equation).update(0)
    it
  }
  set math.equation(numbering: num =>
    numbering("(1.1)", ..counter(heading.where(level: 1)).get(), num), number-align: end + bottom
  )

  set figure(numbering: num =>
    numbering("1.1", ..counter(heading.where(level: 1)).get(), num)
  )

  // Metadatos del PDF
  set document(title: titulo, author: autor)

  // Configuración del tamaño de página, márgenes y header, y documento
  set page(
    paper: "a4", 
    margin: (x: 3cm, y: 3cm),
    header: header, 
    footer: footer)
  title
  doc
  pagebreak()
  toc()
}

// Bloque verde
#let bloque1(res) = {
  set enum(
   full: true, // necessary to receive all numbers at once, so we can know which level we are at
   numbering: (..nums) => {
     let nums = nums.pos()  // just positional args
     let num = nums.last()  // just the current level’s number
     let level = nums.len()  // level is the amount of numbers available

     // format for current level (or stop at i. If going too deep)
     let format = ("1)", "a)", "i)").at(calc.min(2, level - 1))
     let result = numbering(format, num) // formatted number
     strong(result)
     },)
  rect(
    width: 100%,
    inset: 8pt,
    radius: 8pt,
    stroke: (paint: rgb(11,175,140), thickness: 3pt),
    res,
  )
}

#let bloque2(res) = {
  set enum(
   full: true, // necessary to receive all numbers at once, so we can know which level we are at
   numbering: (..nums) => {
     let nums = nums.pos()  // just positional args
     let num = nums.last()  // just the current level’s number
     let level = nums.len()  // level is the amount of numbers available

     // format for current level (or stop at i. If going too deep)
     let format = ("1)", "a)", "i)").at(calc.min(2, level - 1))
     let result = numbering(format, num) // formatted number
     strong(result)
     },)
  rect(
    width: 100%,
    inset: 8pt,
    radius: 8pt,
    stroke: (paint: rgb(11,175,140), thickness: 1pt, dash: "dashed"),
    res,
  )
}

// Cita sin autor
#let cita(con) = {
  set align(center)
  block(
    width: 85%,
    quote(emph(con)) + [.]
  )
}

#let idx(N) = {
  h(1.5mm * N)
}


#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el != none and el.func() == eq {
    // Override equation references.
    numbering(
      el.numbering,
      ..counter(eq).at(el.location())
    )
  } else {
    // Other references as usual.
    it
  }
}

// Derivadas
#let ve(vec) = {  
  math.bold(vec)
}

// Implicancia
#let implies = {
  h(.5cm)
  math.arrow.r.double
  h(.5cm)
}
#let iff = {
  h(.5cm)
  math.arrow.l.r.double
  h(.5cm)
}
#let idd = [
  đ
]
#let o = {
  h(.5cm)
  " o "
  h(.5cm)
}
#let y = {
  h(.5cm)
  " y "
  h(.5cm)
}
#let donde = {
  h(.5cm)
  " donde "
  h(.5cm)
}
#let con = {
  h(.5cm)
  " con "
  h(.5cm)
}

#let overbracegreen(x, y) = text(fill: darkgreen, $overbrace(#text(fill: black, $#x$), display(#y))$)
#let underbracegreen(x, y) = text(fill: darkgreen, $underbrace(#text(fill: black, $#x$), display(#y))$)
#let overbracketgreen(x, y) = text(fill: darkgreen, $overbracket(#text(fill: black, $#x$), display(#y))$)
#let underbracketgreen(x, y) = text(fill: darkgreen, $underbracket(#text(fill: black, $#x$), display(#y))$)

#let enlace(url, txt, color: blue) = {
  strong(text(color)[#link(url)[#txt]])
}

#let ybox(con) = {
  box(stroke: rgb("#fffee0") + 10pt, fill: rgb("#fffee0"), con)
}

#let lrang(con) = {
  math.lr([#sym.angle.l #con #sym.angle.r])
}

