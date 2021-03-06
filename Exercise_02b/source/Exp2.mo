package Exp2
  uniontype Exp
    record INT
      Integer integer;
    end INT;

    record BINARY
      Exp exp1;
      BinOp binOp2;
      Exp exp3;
    end BINARY;

    record UNARY
      UnOp unOp;
      Exp exp;
    end UNARY;
  end Exp;

  uniontype BinOp
    record ADD end ADD;
    record SUB end SUB;
    record MUL end MUL;
    record DIV end DIV;
    /* Add POW here */
  end BinOp;

  uniontype UnOp
    record NEG end NEG;
    /* Add FAC here */
  end UnOp;

  function eval
    input Exp inExp;
    output Integer outInteger;
  protected
    Integer ival, v1, v2, v3;
    Exp e, e1, e2;
    BinOp binop;
    UnOp unop;
  algorithm 
    outInteger := match(inExp)
      case INT(integer=ival)
      then ival;
      
      case BINARY(exp1=e1, binOp2=binop, exp3=e2) equation 
        v1 = eval(e1);
        v2 = eval(e2);
        v3 = applyBinop(binop, v1, v2);
      then v3;
      
      case UNARY(unOp=unop, exp=e) equation 
        v1 = eval(e);
        v2 = applyUnop(unop, v1);
      then v2;
    end match;
  end eval;

  function applyBinop
    input BinOp inBinOp1;
    input Integer inInteger2;
    input Integer inInteger3;
    output Integer outInteger;
  protected
    Integer v1, v2;
  algorithm 
    outInteger := match(inBinOp1, inInteger2, inInteger3)
      case (ADD(), v1, v2) then v1+v2;
      case (SUB(), v1, v2) then v1-v2;
      case (MUL(), v1, v2) then v1*v2;
      case (DIV(), v1, v2) then intDiv(v1, v2);
    end match;
  end applyBinop;

  function applyUnop
    input UnOp inUnOp;
    input Integer inInteger;
    output Integer outInteger;
  protected
    Integer v;
  algorithm 
    outInteger := match(inUnOp, inInteger)
      case (NEG(), v) then -v;
    end match;
  end applyUnop;
end Exp2;
