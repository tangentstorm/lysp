program lysp;
uses gc;

{-- garbage collection callbacks -- }

  procedure mark( p : pointer );
  begin
  end;

  procedure free( p : pointer );
  begin
  end;

{-- main code --}

var i : integer;
begin
  gc.mark := @mark;
  gc.free := @free;
end.
