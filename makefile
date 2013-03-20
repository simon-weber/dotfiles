all: rm_old_files copy

.FORCE:

rm_old_files: .FORCE
	# eg rm -rf ~/removed_at_some_point

copy: .FORCE
	cd home; find . | cpio -pduv ~
