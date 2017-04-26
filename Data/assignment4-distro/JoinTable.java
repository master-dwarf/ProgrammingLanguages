import java.util.*;

/**
 * JoinTable - this class implements the join operation of a
 * relational DB
 *
 */

public class JoinTable extends Table {

    Table first_join_tab;
    Table second_join_tab;
    String[] attr_names_table_one, attr_names_table_two, attr_types_table_one, attr_types_table_two, attr_names, attr_types;
    Conditional cond;

    /**
     * @param t1 - One of the tables for the join
     * @param t2 - The other table for the join.  You are guaranteed
     * that the tables do not share any common attribute names.
     * @param c - the conditional used to make the join
     *
     */
    public JoinTable(Table t1, Table t2, Conditional c) {

	super("Joining " + t1.toString() + " " + t2.toString() + " on condiition " + c.toString());
	first_join_tab = t1;
	second_join_tab = t2;

  cond = c;

  attr_names_table_one = t1.attrib_names();
  attr_types_table_one = t1.attrib_types();

  attr_names_table_two = t2.attrib_names();
  attr_types_table_two = t2.attrib_types();

    }

    public Table [] my_children () {
	return new Table [] { first_join_tab, second_join_tab };
    }

    public Table optimize() {
	// Right now no optimization is done -- you'll need to improve this
	return this;
    }

    public ArrayList<Tuple> evaluate() {
	ArrayList<Tuple> tuples_to_return = new ArrayList<Tuple>();

	// Here you need to add the correct tuples to tuples_to_return
	// for this operation

      ArrayList<Tuple> tuples1 = first_join_tab.evaluate();
      ArrayList<Tuple> tuples2 = second_join_tab.evaluate();

      for(Tuple a : tuples1){
        for(Tuple b : tuples2){
          Tuple ret = joinTuple(a,b);
          if(cond == null)
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
        // System.out.println(a.get_val(cv).toString());
        values.add(a.get_val(cv).toString());
      }
      for(String cv : attr_names_table_two){
        // System.out.println(b.get_val(cv).toString());
        values.add(b.get_val(cv).toString());
      }
      String[] newValues = values.toArray(new String[values.size()]);

      attr_names = new String[values.size()];
      for(int i=0;i<attr_names.length;i++){
        if(i < attr_names_table_one.length)
          attr_names[i] = attr_names_table_one[i];
        else
          attr_names[i] = attr_names_table_two[i - attr_names_table_one.length];
      }

      attr_types = new String[values.size()];
      for(int i=0;i<attr_types.length;i++){
        if(i < attr_types_table_one.length)
          attr_types[i] = attr_types_table_one[i];
        else
          attr_types[i] = attr_types_table_two[i - attr_types_table_one.length];
      }

      Tuple ret = new Tuple(attr_names,attr_types,newValues);
      return ret;
    }


}
