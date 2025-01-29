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

#outline()

Ref Test @bruegge2004object

#pagebreak()

#set heading(numbering: "1.1")

#include "content/introduction/introduction.typ"
#include "content/interface_description/interface_description.typ"
#include "content/functional_description/functional_description.typ"
#include "content/userinterface/user_interface.typ"
#include "content/validation/validation.typ"
#include "content/hardware_description/hardware_description.typ"
