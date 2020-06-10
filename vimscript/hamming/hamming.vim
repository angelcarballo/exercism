"
" This function takes two strings which represent strands and returns
" their Hamming distance.
"
" If the lengths of the strands don't match, throw this exception:
"
"     'left and right strands must be of equal length'
"
function! Distance(strand1, strand2)
  if len(a:strand1) != len(a:strand2)
    throw 'left and right strands must be of equal length'
  endif

  let s:distance = 0

  for pos in range(len(a:strand1))
    if a:strand1[pos] != a:strand2[pos]
      let s:distance += 1
    endif
  endfor

  return s:distance
endfunction
