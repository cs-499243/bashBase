fileChoice=$1
key="¬"

tac $fileChoice | nl -s $key | sort -u -b -k 2 | sort -n -r | sed 's/[^'$key']*'$key'//'

# Note: customisability isn't fully working but serves its purpose for now
# This is essentially a demo of how this works - not perfect but it does the job. 

# Here is the explanation of how each step works...
# - [tac = reverse cat] so read file
# - number each line and end each number with a "key" - some unique character
# - sort... no whitespace... based on 2nd word (1st ignoring numbering)... get unique
# - sort... reversed... based on the numbering system
# - remove all characters up to, and including, the key

# In theory this preserves the order of the file while removing ALL repeats except for the last value. This makes it ideal for bash history uniqueness
# Not quite sure how the unique system for sort works but in my mind it's like "uniq" (compares it to values before and after), hence the awkward resorting. 
