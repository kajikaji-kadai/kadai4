#!/bin/bash

GCD_SCRIPT="./gcd.sh"

# テスト用関数
run_test() {
  expected=$1
  shift
  result=$($GCD_SCRIPT "$@" 2>/dev/null)
  status=$?
         
  if [ "$status" -ne 0 ]; then
    if [ "$expected" = "ERROR" ]; then
      echo "OK（期待通りエラー終了）：$*"
    else
      echo "失敗：$* → 想定外のエラー終了"
      exit 1
    fi
  else
    if [ "$expected" = "$result" ]; then  
      echo "OK：$* = $result"
    else
      echo "失敗：$* → 出力: $result（期待: $expected）"
      exit 1
    fi
  fi
}

# 正常系テスト 期待値　入力1　入力2
run_test 6 12 18
run_test 1 17 31
run_test 10 100 10
run_test 7 7 7

# 異常系テスト　期待値　入力1　入力2
run_test ERROR 0 5
run_test ERROR -3 9
run_test ERROR 10 abc
run_test ERROR 5
run_test ERROR
run_test ERROR 1 2 3
run_test ERROR "" ""

echo "すべてのテストが完了しました。"
