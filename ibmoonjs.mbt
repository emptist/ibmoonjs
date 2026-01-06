// IB MoonBit API - JavaScript/Node.js Target
// Package root file - helper functions and utilities

pub fn fib(n : Int) -> Int64 {
  if n <= 1 {
    1L
  } else {
    fib(n - 1) + fib(n - 2)
  }
}

pub fn sum(data~ : Array[Int], start? : Int = 0, length? : Int) -> Int {
  let len = length.unwrap_or(data.length() - start)
  let mut result = 0
  for i = start; i < start + len; i = i + 1 {
    result = result + data[i]
  }
  result
}
