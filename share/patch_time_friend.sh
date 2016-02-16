#!/bin/bash

gsed -i.backup \
	-e "s/电活/电话/g" \
	-Ee ":a;N;$bash;s/使\s{2,}\n\s*用/使用/g" \
	-e "s/使<br ?\/?>用/使用/g" \
	$1

echo "========== diff START =========="
colordiff -u $1.backup $1
echo "========== diff END =========="

echo "========== you can run 'rm -rf $1.backup' after confirm it =========="
