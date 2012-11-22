{$mode objfpc}
program lysp;
uses gc;

{-- lisp data structures --}

type
  cell = class
  end;
  chargen = procedure ( var ch : char );
  reader = function ( next : chargen ) : cell;

var
  readers : array[ char ] of reader;


{-- reader --}

  function read_illegal( next : chargen ) : cell;
  begin
  end;

  function read_blank( next : chargen ) : cell;
  begin
  end;

  function read_digit( next : chargen ) : cell;
  begin
  end;

  function read_alpha( next : chargen ) : cell;
  begin
  end;

  function read_sign( next : chargen ) : cell;
  begin
  end;

  function read_string( next : chargen ) : cell;
  begin
  end;

  function read_quote( next : chargen ) : cell;
  begin
  end;

  function read_qquote( next : chargen ) : cell;
  begin
  end;

  function read_uquote( next : chargen ) : cell;
  begin
  end;

  function read_list( next : chargen ) : cell;
  begin
  end;

  function read_semi( next : chargen ) : cell;
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


{-- garbage collection callbacks --}

  procedure mark( p : pointer );
  begin
  end;

  procedure free( p : pointer );
  begin
  end;

{-- main code --}

begin
  gc.mark := @mark;
  gc.free := @free;
  init_readers;
end.
