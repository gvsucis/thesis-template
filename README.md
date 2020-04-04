# GVSU Thesis Template

This is a template for a Master of Computing and Information Systems thesis at Grand Valley State
University.

This template is based on GVSU's 2019-20 thesis preparation guidelines. See the [Thesis and
Dissertation Information](https://www.gvsu.edu/gs/thesis-and-dissertation-information-35.htm)
website for the most up to date version of this information.

## Examples and Credit

This template is forked from [this one](https://github.com/gvsucis/thesis-template) designed to
build in the EOS Linux environment by [Sean Fisk](https://github.com/seanfisk). [Eric
Domke](https://github.com/erdomke) ported it to Windows
[here](https://github.com/erdomke/thesis-template).

This template is adapted from [Zach Scrivena](https://github.com/zachscrivena)'s
[Simple-Thesis-Dissertation](https://github.com/zachscrivena/simple-thesis-dissertation) and
modified for GVSU's requirements. Although the content is primarily from here, the repo is forked
from GVSU's template for discoverability.

[Kevin Kredit](https://github.com/kkredit) designed this version of the template to work on Linux or
the Windows Subsystem for Linux. It does not officially support the EOS environment, though it may
build there.

<!-- TODO: add a link to my thesis as soon as it's public -->

The example CV comes from Illinois's graduate school's [CV
samples](https://grad.illinois.edu/sites/default/files/pdfs/cvsamples.pdf).

A prebuilt example of a thesis using this template is available at
[Example/Thesis.pdf](Example/Thesis.pdf).

## Usage

This template is designed to be copied into a subdirectory (perhaps as a submodule) from the main
thesis document. To build a document using this template, first install the following packages, then
run `make` to build the example.

```sh
apt install texlive-latex-extra texlive-generic-extra texlive-xetex texlive-science \
    texlive-publishers msttcorefonts latexmk make
make
```

## Thesis Contents

| **Page Name**                   | **Required**  | **Print page #** | **Page #** | **Source Files**                                             |
| ------------------------------- | ------------- | ---------------- | ---------- | ------------------------------------------------------------ |
| Title page                      | Yes           | No               | 1          | Thesis-FrontMatter.tex                                       |
| Approval page                   | Yes           | No               | 2          | Thesis-FrontMatter.tex, **Forms/ThesisApproval.pdf**\*       |
| Dedication page (limit 2 pages) | Optional      | Yes              | 3          | Thesis-FrontMatter.tex                                       |
| Acknowledgments (limit 2 pages) | Optional      | Yes              | 3 or 4     | Thesis-FrontMatter.tex                                       |
| Preface                         | Optional      | Yes              | (continue) | Thesis-FrontMatter.tex                                       |
| Abstract (limit 350 words)      | Yes           | Yes              | (continue) | Thesis-FrontMatter.tex                                       |
| Table of contents               | Yes           | Yes              | (continue) | Thesis-FrontMatter.tex                                       |
| List of tables                  | If applicable | Yes              | (continue) | Thesis-FrontMatter.tex                                       |
| List of figures                 | If applicable | Yes              | (continue) | Thesis-FrontMatter.tex                                       |
| Key to symbols or abbreviations | If applicable | Yes              | (continue) | **Thesis.tex**                                               |
| Text and supplementary pages    | Yes           | Yes              | (continue) | **Thesis.tex**                                               |
| Appendices                      | If applicable | Yes              | (continue) | **Thesis.tex**                                               |
| Glossary                        | Optional      | Yes              | (continue) | Thesis-BackMatter.tex, **Thesis-Glossary.tex**               |
| Bibliography/References         | Yes           | Yes              | (continue) | Thesis-BackMatter.tex, **Thesis.bib**                        |
| Vita                            | Optional      | Yes              | (continue) | Thesis-BackMatter.tex, **Forms/CurriculumVitae.pdf**         |
| ScholarWorks@GVSU agreement     | Yes           | No               | NA         | Thesis-BackMatter.tex, **Forms/ScholarWorksAgreement.pdf**\* |

\*Forms are available for download as Microsoft Word documents or PDF forms at GVSU's
[website](https://www.gvsu.edu/gs/thesis-and-dissertation-information-35.htm).

Source files emphasized in **bold** must be provided by the thesis author. Other files can be taken
from the template with little or no modification.

## License

This template is licensed under the LaTeX Project Public License v1.3c. See the [license](LICENSE)
text for full details.
