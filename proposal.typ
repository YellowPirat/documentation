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
  transparency_ai_tools: include "/content/proposal/transparency_ai_tools.typ",
)


#set heading(numbering: none)
#include "/content/proposal/abstract.typ"

#set heading(numbering: "1.1")
#include "/content/proposal/introduction.typ"
#include "/content/proposal/problem.typ"
#include "/content/proposal/motivation.typ"
#include "/content/proposal/objective.typ"
#include "/content/proposal/schedule.typ"
