# hello.

[ricostacruz.com](http://ricostacruz.com)

## Dev notes

- `make start` to start server

- iterate on the `develop` branch (css changes, etc) and merge to master when 
ready

- bundler (`_/Gemfile`) is here to keep github-pages gems consistent

## What's here

- `_/` - boilerplate stuff are placed here as much as possible.

- `/pages/ref.html` - style references

Markdown reference
------------------

### Block variants

These variants work on almost all content blocks: `p`, `h2..h6`, `blockquote`, 
      and so on... even `hr`. (See `standard-block.sass`)

 - `.wide` - makes it wider.
 - `.spaced` - big spaces around it.
 - `.center` - text align center.

### Blocks

Custom blocks. (See `block.*.sass`)

 - `.brief-intro` - a large paragraph.
 - `.pull-quote` - pull quote.
 - `.panorama-section` - panoramic section. (variants: `-fixed`)
 - `hr` - horizontal rule. (variants: `-stars`)
 - `.with-footnote`. - has a caption. put a blockquote inside it. (variants: 
     `-left`, `-right`)

