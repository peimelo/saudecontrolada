#BetterErrors.editor='x-mine://open?file=%{file}&line=%{line}' if defined? BetterErrors
BetterErrors.editor='rubymine://open?url=file://%{file}&line=%{line}' if defined? BetterErrors
#BetterErrors.editor = :textmate if defined? BetterErrors
#https://github.com/johnvross/gedit_better_errors/blob/master/README.md
#BetterErrors.editor = "run-gedit://open?url=%{file}&line=%{line}"