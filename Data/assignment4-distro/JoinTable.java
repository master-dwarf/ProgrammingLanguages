import java.util.*;

/**
* JoinTable - this class implements the join operation of a
* relational DB
*
*/

public class JoinTable extends Table {

  Table first_join_tab;
  Table second_join_tab;
  String[] attr_names_table_one, attr_names_table_two, attr_types_table_one, attr_types_table_two;
  Conditional cond;

  /**
  * @param t1 - One of the tables for the join
  * @param t2 - The other table for the join.  You are guaranteed
  * that the tables do not share any common attribute names.
  * @param c - the conditional used to make the join
  *
  */
  public JoinTable(Table t1, Table t2, Conditional c) {

    super("Joining " + t1.toString() + " " + t2.toString() + " on condiition " + ((c==null)? "" : c.toString()));
    first_join_tab = t1;
    second_join_tab = t2;

    attr_names = joinNames(t1,t2);
    attr_types = joinTypes(t1,t2);
    cond = c;

    attr_names_table_one = t1.attrib_names();
    attr_names_table_two = t2.attrib_names();

    attr_types_table_one = t1.attrib_types();
    attr_types_table_two = t2.attrib_types();

  }

  public Table [] my_children () {
    return new Table [] { first_join_tab, second_join_tab };
  }

  public Table optimize() {
    if(cond instanceof ComparisonConditional){
      ComparisonConditional c = (ComparisonConditional) cond;
      if(c.right.isConstant()){
        if(tableCheck(first_join_tab,c.left.toString())){
          return new JoinTable( new SelectTable(first_join_tab,cond), second_join_tab, null).optimize();
        }
        else if(tableCheck(second_join_tab,c.left.toString())){
          return new JoinTable(first_join_tab, new SelectTable(second_join_tab,cond), null).optimize();
        }
      }
      else{
        if(tableCheck(first_join_tab,c.left.toString()) && tableCheck(first_join_tab,c.right.toString())){
          return new JoinTable( new SelectTable(first_join_tab,cond), second_join_tab, null).optimize();
        }
        else if(tableCheck(second_join_tab,c.left.toString()) && tableCheck(second_join_tab,c.right.toString())){
          return new JoinTable(first_join_tab, new SelectTable(second_join_tab,cond), null).optimize();
        }
      }
    }
    return new JoinTable(first_join_tab, second_join_tab, cond);
  }

  public boolean tableCheck(Table a, String s){
    for(String x : a.attr_names){
      if(x.equals(s)){return true;}
    }
    return false;
  }

  public ArrayList<Tuple> evaluate() {
    ArrayList<Tuple> tuples_to_return = new ArrayList<Tuple>();
    // Here you need to add the correct tuples to tuples_to_return
    // for this operation
    if (cond  instanceof  ANDConditional) {
      for (int i = 0; i < ((ANDConditional) cond).my_conds.length;i++){
        ((ANDConditional)cond).my_conds[i].set_both_leaves_table(this);
      }
    }
    else if(cond == null){}
    else{
      ((ComparisonConditional) cond).set_both_leaves_table(this);
    }
      ArrayList<Tuple> tuples1 = first_join_tab.evaluate();
      ArrayList<Tuple> tuples2 = second_join_tab.evaluate();
      for(Tuple a : tuples1){
        for(Tuple b : tuples2){
          Tuple ret = joinTuple(a,b);
          if(cond==null)
          tuples_to_return.add(ret);
          else if(cond.truthVal(ret))
          tuples_to_return.add(ret);
        }
      }
      // It should be done with an efficient algorithm based on
      // sorting or hashing
      profile_intermediate_tables(tuples_to_return);
      return tuples_to_return;
    }

    public Tuple joinTuple(Tuple a, Tuple b){
      ArrayList<String> values = new ArrayList<String>();
      for(String cv : attr_names_table_one){
        values.add(a.get_val(cv).toString());
      }
      for(String cv : attr_names_table_two){
        values.add(b.get_val(cv).toString());
      }
      String[] newValues = values.toArray(new String[values.size()]);
      Tuple ret = new Tuple(attr_names,attr_types,newValues);
      return ret;
    }
    public String[] joinNames(Table a, Table b){
      attr_names = new String[a.attrib_names().length + b.attrib_names().length];
      attr_names_table_one = a.attrib_names();
      attr_names_table_two = b.attrib_names();
      for(int i=0;i<attr_names.length;i++){
        if(i < attr_names_table_one.length){
          attr_names[i] = attr_names_table_one[i];
        }
        else{
          attr_names[i] = attr_names_table_two[i - attr_names_table_one.length];
        }
      }
      return attr_names;
    }

    public String[] joinTypes(Table a, Table b){
      attr_types = new String[a.attrib_types().length + b.attrib_types().length];
      attr_types_table_one = a.attrib_types();
      attr_types_table_two = b.attrib_types();
      for(int i=0;i<attr_types.length;i++){
        if(i < attr_types_table_one.length)
        attr_types[i] = attr_types_table_one[i];
        else
        attr_types[i] = attr_types_table_two[i - attr_types_table_one.length];
      }
      return attr_types;
    }
  }
