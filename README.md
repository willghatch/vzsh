VZSH
====

vzsh is a project that has grown out of my constant configuration of dotfiles.  I realized that my configuration was huge enough, and that others might benefit if I extracted the more generic parts.

Why?
----

- Snippets -- expand text anywhere on the command line, like aliases.
- keys -- useful functions for defining prefix commands (emacs-style!) with built in key listing with C-h, as well as a more useful vim/emacs hybrid keymap out of the box.
- grml -- I took a bunch of their stuff, modified it, and stuck it in here.  It represents, I think, the cream of the grml crop.
- setopt -- set basic, sane default options.
- prompt -- ok, this is pretty much the prompt system I made myself before I learned about the built-in themes.  This will probably turn into a theme later.
- completion -- after so much frustration trying to figure out how to customize different completion commands to behave the way I wanted, I wrapped zsh completion with my own system to be able to define different keys to complete in different ways.  This was largely born out of frustration, and if I learn about the "right way" to do this later, it may simply be replaced by some clear documentation about that, with a good default setup.

In the end, this makes a great batteries-included zsh starter kit, like grml or oh-my-zsh.

Later I'll probably make these bundle-able by antigen.  Which leads me to...

Suggestions
-----------

Check out [antigen](https://github.com/zsh-users/antigen) as well - it's a more modular way of using all that oh-my-zsh stuff.

You want to know other plugins I recommend?
[opp.zsh](https://github.com/hchbaw/opp.zsh)
[vi visual mode](https://github.com/alfredodeza/zsh-plugins/blob/master/vi/zle_vi_visual.zsh)
[syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
[history substring search](https://github.com/zsh-users/zsh-history-substring-search)
[warp directory](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/wd)

And then I have my dotfiles repo with all of my less generic zsh configuration.

Default Install
---------------

Put the repo at ~/.config/vzsh

    mkdir -p ~/.config
    cd ~/.config
    git clone https://github.com/willghatch/vzsh.git

source vzshrc

    echo "source ~/.config/vzsh/vzsh.zsh" >> ~/.zshrc

done!

Want more control?
------------------

Copy vzsh.zsh out of the repo and set it up however you like -- it is a template for your own configuration.  It is set up in modules that are independent, so you can pick and choose the parts you find useful.

Questions? Comments?
--------------------

I'd like to hear.  Shoot me an email at willghatch@gmail.com.  I would love feedback from some zsh experts -- I don't personally know any, so your feedback would be great.
