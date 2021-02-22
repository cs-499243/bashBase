# Where is the functionality from before?
# You can do everything easier with, for example, [touch test-{0..100}-item]

[[ -z "$@" ]] && adCommand="touch" || adCommand="$@"
echo "Running command [$adCommand]"

while :; do
	read -p ' - ' adInput

	[[ -z "$adInput" ]] && break

	$adCommand "$adInput" || echo "Invalid Command"
done
