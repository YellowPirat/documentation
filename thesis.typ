#import "/layout/proposal_template.typ": *
#import "/metadata.typ": *
#import "/utils/todo.typ": *
#import "/utils/print_page_break.typ": *

#set document(title: titleEnglish, author: author)

#show: proposal.with(
  title: titleEnglish,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  university: university,
  description: description,
  bib_path: bib_path,
  logo_path: logo_path,
  startDate: startDate,
  submissionDate: submissionDate,
)


#set heading(numbering: none)

#outline(
  indent: 1.5em
)

#pagebreak()

#set heading(numbering: "1.1")

#include "content/introduction/introduction.typ"
#include "content/interface_description/interface_description.typ"
#include "content/functional_description/functional_description.typ"
#include "content/userinterface/user_interface.typ"
#include "content/validation/validation.typ"
#include "content/hardware_description/hardware_description.typ"

#set heading(numbering: none)
#heading("List of Figures")
#outline(
  title: none,
  target: figure.where(kind: image)
)
#pagebreak()

#set heading(numbering: none)
#heading("List of Tables")
#outline(
  title: none,
  target: figure.where(kind: table)
) 
