#!/bin/bash
# Compatible with LFS 12.3 and glibc 2.41
set -euo pipefail

cat << EOF | while read -r -a args; do localedef "${args[@]}"; done
-i C -f UTF-8 C.UTF-8
-i cs_CZ -f UTF-8 cs_CZ.UTF-8
-i de_DE -f ISO-8859-1 de_DE
-i de_DE@euro -f ISO-8859-15 de_DE@euro
-i de_DE -f UTF-8 de_DE.UTF-8
-i el_GR -f ISO-8859-7 el_GR
-i en_GB -f ISO-8859-1 en_GB
-i en_GB -f UTF-8 en_GB.UTF-8
-i en_HK -f ISO-8859-1 en_HK
-i en_PH -f ISO-8859-1 en_PH
-i en_US -f ISO-8859-1 en_US
-i en_US -f UTF-8 en_US.UTF-8
-i es_ES -f ISO-8859-15 es_ES@euro
-i es_MX -f ISO-8859-1 es_MX
-i fa_IR -f UTF-8 fa_IR
-i fr_FR -f ISO-8859-1 fr_FR
-i fr_FR@euro -f ISO-8859-15 fr_FR@euro
-i fr_FR -f UTF-8 fr_FR.UTF-8
-i is_IS -f ISO-8859-1 is_IS
-i is_IS -f UTF-8 is_IS.UTF-8
-i it_IT -f ISO-8859-1 it_IT
-i it_IT -f ISO-8859-15 it_IT@euro
-i it_IT -f UTF-8 it_IT.UTF-8
-i ja_JP -f EUC-JP ja_JP
-i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true
-i ja_JP -f UTF-8 ja_JP.UTF-8
-i nl_NL@euro -f ISO-8859-15 nl_NL@euro
-i ru_RU -f KOI8-R ru_RU.KOI8-R
-i ru_RU -f UTF-8 ru_RU.UTF-8
-i se_NO -f UTF-8 se_NO.UTF-8
-i ta_IN -f UTF-8 ta_IN.UTF-8
-i tr_TR -f UTF-8 tr_TR.UTF-8
-i zh_CN -f GB18030 zh_CN.GB18030
-i zh_HK -f BIG5-HKSCS zh_HK.BIG5-HKSCS
-i zh_TW -f UTF-8 zh_TW.UTF-8
EOF
