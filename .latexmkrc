$pdf_mode = 1;
$dvi_mode = $postscript_mode = 0;
@default_files = ('example.tex');
$bibtex_use = 2;

add_cus_dep('glo', 'gls', 0, 'indx');
add_cus_dep('acn', 'acr', 0, 'indx');
sub indx {
    return Run_subst("$makeindex -t \"%S.log\" -s \"%R.ist\"");
}

$clean_ext = "loa ist glo glo.log gls glsdefs acn acn.log acr";
