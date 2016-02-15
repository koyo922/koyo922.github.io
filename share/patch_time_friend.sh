#!/bin/bash

sed -Ei ".backup" \
	-e "s/电活/电话/g" \
	-e "s/使  用/使用/g" \
	-e "s/使<br ?\/?>用/使用/g" \
	$1

echo "========== the diff START =========="
diff $1.backup $1
echo "========== the diff END =========="

echo "========== you can run 'rm -rf $1.backup' after confirm it =========="
