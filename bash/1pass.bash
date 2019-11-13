function 1pass-list {
    op list items  | jq -r '.[] | .overview.title'
}

function 1pass-user {
    op get item $1 | jq -r '.details.fields[] | select(.designation=="username").value' | xclip -selection c
}

function 1pass-pass {
    op get item $1 | jq -r '.details.fields[] | select(.designation=="password").value' | xclip -selection c
}
