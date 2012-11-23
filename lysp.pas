{$i xpc.inc} {$macro on}
program lysp;
uses gc, ln;

{-- lisp data structures --}

type
  _tag = ( t_nil, t_int, t_str, t_sym, t_cel,
           t_sub, t_exp, t_fsub, t_fexp, t_psub );
  pstr = ^string;
  cell = class;
  celldata = record
  case tag : _tag of
    t_nil : ( );
    t_int : ( int : integer );
    t_str : ( str : pstr );
    t_sym : ( sym : pstr );
    t_cel : ( cel : cell );
    t_sub : ( sub : cell );
    t_exp : ( exp, env : cell );
    //  foreign functions
    // t_fsub : ( fsub : cell );
    // t_fexp : ( fexp : cell );
    // t_psu	 : ( psub : cell );
  end;
  cell = class
    tag : _tag; data : celldata;
    constructor make_nil;
    constructor make_int( int : integer );
    constructor make_str( str : string );
    constructor make_sym( sym : string );
    constructor make_cel( cel : cell );
    constructor make_sub( sub : cell );
    constructor make_exp( exp, env : cell );
  end;
  chargen = procedure ( var ch : char );

  {$define as_reader := ( next : chargen ) : cell }
  reader = function as_reader;

var
  readers : array[ char ] of reader;
  main_prompt : string = '--> ';
  more_prompt : string = '... ';

{-- cell types --}

  constructor cell.make_nil;
  begin self.tag := t_nil;
  end;

  constructor cell.make_int( int : integer );
  begin tag := t_int; data.int := int
  end;

  constructor cell.make_str( str : string );
  begin tag := t_str; data.str := @str
  end;

  constructor cell.make_sym( sym : string );
  begin tag := t_sym; data.sym := @sym
  end;

  constructor cell.make_cel( cel : cell );
  begin tag := t_cel; data.cel := cel
  end;

  constructor cell.make_sub( sub : cell );
  begin tag := t_sub; data.sub := sub
  end;

  constructor cell.make_exp( exp, env : cell );
  begin tag := t_exp; data.exp := exp; data.env := env
  end;

{-- reader --}

  function read_illegal as_reader;
  begin
  end;

  function read_blank as_reader;
  begin
  end;

  function read_digit as_reader;
  begin
  end;

  function read_alpha as_reader;
  begin
  end;

  function read_sign as_reader;
  begin
  end;

  function read_string as_reader;
  begin
  end;

  function read_quote as_reader;
  begin
  end;

  function read_qquote as_reader;
  begin
  end;

  function read_uquote as_reader;
  begin
  end;

  function read_list as_reader;
  begin
  end;

  function read_semi as_reader;
  begin
  end;

  procedure init_readers;
    var ch : char;
    procedure use( r : reader ; chars : string );
    begin for ch in chars do readers[ ch ] := r;
    end;
  begin
    for ch := #0 to #255 do readers[ ch ] := @read_illegal;
    use( @read_alpha,  'ABCDEFGHIJKLMNOPQRSTUVWXYZ' );
    use( @read_alpha,  '!#$%&*/:<=>?@\\^_|~' );
    use( @read_alpha,  '.' );
    use( @read_blank,  #01#02#03#04#05#06#07#08 );
    use( @read_blank,  #09#10#11#12#13#14#15#16 );
    use( @read_blank,  #17#18#19#20#21#22#23#24 );
    use( @read_blank,  #25#26#27#28#29#30#31#32 );
    use( @read_digit,  '0123456789' );
    use( @read_sign,   '+-' );
    use( @read_string, '\' );
    use( @read_quote,  ''''  );
    use( @read_qquote, '' );
    use( @read_uquote, ',' );
    use( @read_list,   '( [{' );
    use( @read_semi,   ';' );
  end;

  function parse( line : string; var expr : cell ) : boolean;
  begin
    expr := cell.make_nil;
    result := true;
  end;

{-- evaluator --}

  function eval( expr : cell ) : cell;
  begin
    result := expr;
  end;

{-- garbage collection callbacks --}

  procedure mark( p : pointer );
  begin
  end;

  procedure free( p : pointer );
  begin
  end;

{-- predefined symbols --}

  procedure init_globals;
  begin
  end;

  function print( value : cell ) : cell;
  begin
    with value do begin
      case tag of
        t_nil : ;
        t_int : write( data.int );
        t_str : write( '"', data.str^, '"' );
        t_sym : write( data.sym^ );
        t_cel : write( '<cel>' );
        t_sub : write( '<sub>' );
        t_exp : write( '<exp>' );
      end;
    end;
    result := value;
  end;

{-- read-eval-print loop --}

  procedure completion( const buf : string; var comps : ln.Completions );
  begin
  end;

  procedure repl;
    var line, prompt : string; expr, value : cell;
  begin
    prompt := main_prompt;
    ln.on_complete := @completion;
    while ln.prompt( prompt, line ) do begin
      writeln;
      prompt := main_prompt;
      if parse( line, expr ) then begin
	value := eval( expr );
	if value.tag <> t_nil then begin
	  print( value );
	  writeln;
	end
      end else prompt := more_prompt
    end;
    writeln;
  end;

{-- main code --}

begin
  gc.mark := @mark;
  gc.free := @free;
  init_readers;
  //  todo : dynamic library calls
  init_globals;
  repl;
end.
