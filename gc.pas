unit gc;
interface

  type callback = procedure( p : pointer );
  var mark, free : callback;

implementation
end.