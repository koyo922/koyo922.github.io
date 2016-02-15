#!/bin/bash

sed -Ei ".backup" \
	-e "s/电活/电话/g" \
	-e "s/使  用/使用/g" \
	-e "s/使<br ?\/?>用/使用/g" \
	-e "s/我把主动工作时间/我主动把工作时间/g" \
	$1

diff $1.backup $1
