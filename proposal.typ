#import "/layout/proposal_template.typ": *
#import "/metadata.typ": *
#import "/utils/todo.typ": *

#set document(title: titleEnglish, author: author)

#show: proposal.with(
  title: titleEnglish,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  university: university,
  description: description,
  logo_path: logo_path,
  startDate: startDate,
  submissionDate: submissionDate,
  transparency_ai_tools: include "/content/transparency_ai_tools.typ",
)


#set heading(numbering: none)
#include "/content/abstract.typ"

#set heading(numbering: "1.1")
#include "/content/introduction.typ"
#include "/content/problem.typ"
#include "/content/motivation.typ"
#include "/content/objective.typ"
#include "/content/schedule.typ"
