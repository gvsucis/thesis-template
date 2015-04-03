Todo for the Thesis Template
============================

- Fix underscores in example PDF files.
- Remove warnings about tagged PDFs (export minimal from Word or use qpdf).
- Make sure formatting is correct.
- Make sure distribution task is working properly.
- Make xelatex a mandatory tool.
- Hard-code detection of `pygmentize` in `~/.local/bin` (also see minted/Pygments todo).
- Split into multi-file document if possible. Check out subfiles.
- Improve usage instructions.
- Improve maintenance instructions.
- Add instructions on changing the filename.
- Add instructions on the `build/` directory.
- Add table example with tabu.
- Explain more examples in the document instead of just having my thesis.
- Add suggestion to alias Waf.
- Add LaTeX links (Wikibook, etc.).
- Add Git links (try.github.io, book).
- xdg-open hangs Waf when run (also fix in mEOS).
- Drop READMEs in every directory.
- pylint/flake8 for Python files.
- Use lualatex when the installation on EOS is fixed.
- When minted supports specification of a path to `pygmentize`, find it in Waf's configure and substitute it into a TeX file. While the `pygmentize` path hasn't been a problem in the past, it's nice to guarantee stable rebuilds and play well with Waf's model.
