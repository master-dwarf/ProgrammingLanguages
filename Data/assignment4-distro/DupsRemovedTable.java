import java.util.*;

/**
 * DupsRemovedTable - this class implements the duplicate removal operation of a
 * relational DB
 */

public class DupsRemovedTable extends Table {

    Table tab_dups_removed_from;

    /**
     * @param t - the table from which duplicates are to be removed
     *
     */
    public DupsRemovedTable(Table t) {

	super("Removing duplicates from " + t.toString());
	tab_dups_removed_from = t;

  attr_names = t.attrib_names();
  attr_types = t.attrib_types();

    }

    public Table [] my_children () {
	return new Table [] { tab_dups_removed_from };
    }

    public Table optimize() {
	// Right now no optimization is done -- you'll need to improve this
	return this;
    }

    public ArrayList<Tuple> evaluate() {
	ArrayList<Tuple> tuples_to_return = new ArrayList<Tuple>();

	// Here you need to add the correct tuples to tuples_to_return
	// for this operation

  //  if(!tuples_to_return.contains(Tuple))
  //    add to tuples_to_return

  ArrayList<Tuple> tuples1 = tab_dups_removed_from.evaluate();
  ListIterator iterate_tuples = tuples1.listIterator(0);

  while (iterate_tuples.hasNext()) {
      Tuple tupleToProject = (Tuple) iterate_tuples.next();
      String[] projectedValues = new String[attr_names.length];
      int[] hashValues = new int[attr_names.length];
      boolean alreadyadded = false;
      for (int i=0; i < attr_names.length; i++) {
        projectedValues[i] = tupleToProject.get_val(attr_names[i]).toString();
        hashValues[i] = tupleToProject.get_val(attr_names[i]).hashCode();
      }
      Tuple projectedTuple = new Tuple(attr_names, attr_types, projectedValues);
      if(tuples_to_return.isEmpty()){
        tuples_to_return.add(projectedTuple);
      }
      else{
        Iterator<Tuple> added_tuples = tuples_to_return.iterator();
        while(added_tuples.hasNext()){
          Tuple addedToProject = (Tuple) added_tuples.next();
          int[] addedHash = new int[attr_names.length];
          int count = 0;
          for(int i=0;i<attr_names.length;i++){
            addedHash[i] = addedToProject.get_val(attr_names[i]).hashCode();
            if(addedHash[i]==hashValues[i]){count = count + 1;}
          }
          if(count==(attr_names.length)){alreadyadded = true;}
        }
        if(alreadyadded==false){tuples_to_return.add(projectedTuple);}
      }
    }

	// It should be done with an efficient algorithm based on
	// sorting or hashing

	profile_intermediate_tables(tuples_to_return);
	return tuples_to_return;

    }

}
