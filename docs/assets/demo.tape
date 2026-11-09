# Record with: vhs docs/assets/demo.tape
# Runs in a throwaway HOME with a bare prompt, so no local user name or path is visible.
Output docs/assets/demo.gif
Set Shell "bash"
Set FontFamily "Menlo"
Set FontSize 18
Set Width 1200
Set Height 720
Set Theme "Dracula"
Set Padding 24
Set TypingSpeed 35ms

Hide
Type "export HOME=$(mktemp -d) PS1='$ ' TF_IN_AUTOMATION=1; clear"
Enter
Sleep 500ms
Show

Type "terragrunt graph-dependencies --terragrunt-working-dir live/dev 2>/dev/null | grep -c -- '->'"
Sleep 300ms
Enter
Sleep 3s
Type "./scripts/demo-run-all.sh"
Sleep 300ms
Enter
Wait+Screen@240s /units valid/
Sleep 4s
