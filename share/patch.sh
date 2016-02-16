#!/bin/bash

gsed -i.backup \
	-e "s/刘蝶/蝶蝶/g" \
	-e "s/孙文婷/小孙/g" \
	-e "s/王荆沁/王总/g" \
	$1

echo "========== diff START =========="
colordiff -u $1.backup $1
echo "========== diff END =========="

echo "========== you can run 'rm -rf $1.backup' after confirm it =========="
