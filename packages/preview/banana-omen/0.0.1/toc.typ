#let toc(title: "Índice", depth: 3) = {

  // Tabla de contenidos
  show outline.entry.where(
      level: 1
    ): it => {
      strong(it)
  }
  
  show outline.entry.where(
      level: 3
    ): it => {
      set text(gray)
      it
  }
  
  outline(
    title: title,
    depth: depth,
    indent: 2em
  )
}
