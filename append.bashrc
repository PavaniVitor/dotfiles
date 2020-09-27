###################
bind 'TAB':menu-complete

# Display a list of the matching files

bind "set show-all-if-ambiguous on"

# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press

bind "set menu-complete-display-prefix on"

# Cycle through history based on characters already typed on the line

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
