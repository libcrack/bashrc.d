# ruby helpers

ruby-env-help(){
    cat <<EOF
     Two ENV variables control the 'gem' command:

       GEM_HOME: the single path to a gem dir where gems are installed
       GEM_PATH: a standard PATH to gem dirs where gems are found

     A gem directory is a directory that holds gems.  The 'gem' command will lay
     out and utilize the following structure:

       bin               # installed bin scripts
       cache             # .gem files  ex: cache/gem_name.gem
       doc               # rdoc/ri     ex: doc/gem_name/rdoc
       gems              # gem file    ex: gems/gem_name/lib/gem_name.rb
       specifications    # gemspecs    ex: specifications/gem_name.gemspec

     As an example of usage:

EOF
    cat | pygmentize -l ruby <<EOF
    export GEM_HOME=a
    export GEM_PATH=a
    gem install rack
    gem list                    # shows rack

    export GEM_HOME=b
    export GEM_PATH=b
    gem install rake
    gem list                    # shows rake (not rack)

    export GEM_PATH=a:b
    gem list                    # shows rake and rack

    And if you set GEM_HOME=a:b, you will install into the 'a:b' directory :)

EOF

}

export RUBY_VERSION="$(ruby -v | cut -f1 -dp | awk '{print $2}')"
export GEM_HOME="$(ruby -e 'print "#{Gem.user_dir}"')"

if [[ ! ${GEM_PATH} =~ ${GEM_HOME} ]]; then
    export GEM_PATH="${HOME}/.gem/ruby/${RUBY_VERSION}"
fi

if [[ $RUBY_VERSION =~ "1.9" ]]; then
    export GEM_PATH="/opt/ruby1.9/lib/ruby/gems/1.9.1:${GEM_PATH}"
fi

if [[ ! $PATH =~ $GEM_HOME ]]; then
    export PATH="${GEM_HOME}/bin:${PATH}"
fi

[[ -f ~/.gemrc ]] || {
    cat > ~/.gemrc <<EOF
install: --no-rdoc --no-ri
update:  --no-rdoc --no-ri
EOF
}

ruby-toggle(){
    if [[ "${RUBY_VERSION}" =~ "1.9" ]]; then
        echo -e ">> Enabling ruby ${YELLOW}2${RESET}\007"
        # set ruby 2.2 by deleting ~/.local/bin links
        for x in {ruby,bundle,rake}; do
            rm ~/.local/bin/${x} 2>/dev/null
        done
        PATH=${PATH/"${GEM_HOME}/bin:"/}
        export RUBY_VERSION="$(/sbin/ruby -v | cut -f1 -dp | awk '{print $2}')"
        export GEM_HOME="$(/sbin/ruby -e 'print "#{Gem.user_dir}"')"
        export PATH="${GEM_HOME}/bin:${PATH}"
    else
        echo -e ">> Enabling ruby ${YELLOW}1.9${RESET}\007"
        # set ruby 1.9 by creating links in ~/.local/bin
        for x in {ruby,bundle,rake}; do
            rm ~/.local/bin/${x} 2>/dev/null
            ln -s /opt/ruby1.9/bin/${x} ~/.local/bin/${x}
        done
        PATH=${PATH/"${GEM_HOME}/bin:"/}
        export RUBY_VERSION="$(/sbin/ruby-1.9 -v | cut -f1 -dp | awk '{print $2}')"
        export GEM_HOME="$(/sbin/ruby-1.9 -e 'print "#{Gem.user_dir}"')"
        export PATH="${GEM_HOME}/bin:${PATH}"
    fi
}

archlinux-ruby(){ ruby-toggle; }
