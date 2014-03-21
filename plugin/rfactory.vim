function! s:FactoryOnCurrentLine()
  let fg_methods = ['create', 'build', 'build_stubbed', 'attributes_for']
  let method_pattern = '\<\%('. join(fg_methods, '\|') . '\)' " Non capturing 'or'
  let symbol_pattern = '\(:\w\+\)'
  let optional_trait_pattern = '\%(, '.symbol_pattern.'\)\?'
  let pattern = method_pattern . '.' . symbol_pattern . optional_trait_pattern
  return matchlist(getline('.'), pattern)
endfunction

function! s:Rfactory()
  let factory = s:FactoryOnCurrentLine()
  if len(factory)
    let factory_name = factory[1]
    let factory_trait = factory[2]
    split spec/factories.rb
    call search('.*factory.' . factory_name)
    if factory_trait !=? ''
      call search('.*trait.' . factory_trait)
    endif
    normal! zz
  else
    " s:ShowErrorMessage('No factory call found on current line.')
  endif
endfunction

command! Rfactory :call <sid>Rfactory()

nnoremap go :Rfactory<CR>
