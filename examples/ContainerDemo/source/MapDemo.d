module MapDemo;

import std.stdio;

import hunt.container.HashMap;
import hunt.container.TreeMap;
import hunt.container.Map;
import hunt.container.Iterator;

import std.stdio;
import std.conv;
import std.range;

class MapDemo
{
    
    void testHashMapForeach()
    {
        // https://stackoverflow.com/questions/4234985/how-to-for-each-the-hashmap
        // HashMap Declaration
        writeln("Testing HashMap...");
        HashMap!(int, string) hmap = new HashMap!(int, string)();

        //Adding elements to LinkedHashMap
        hmap.put(22, "Abey");
        hmap.put(33, "Dawn");
        hmap.put(1, "Sherry");
        hmap.put(2, "Karon");
        hmap.put(100, "Jim");

        writeln(hmap.toString());

        writeln("\nTesting HashMap foreach1...");
        foreach (int key, string v; hmap)
        {
            writeln("Key is: " ~ key.to!string ~ " & Value is: " ~ v);
        }

        writeln("\nTesting HashMap foreach2...");
        foreach (MapEntry!(int, string) entry; hmap)
        {
            writeln("Key is: " ~ entry.getKey().to!string ~ " & Value is: " ~ entry.getValue());
        }

        writeln("\nTesting HashMap byKey1...");
        // Iterator!int keyIterator  = hmap.byKey();
        // while(keyIterator.hasNext)
        // {
        //         writeln("Key is: " ~ keyIterator.next().to!string());
        // }

        InputRange!int keyIterator = hmap.byKey();
        while (!keyIterator.empty)
        {
            writeln("Key is: " ~ keyIterator.front.to!string());
            keyIterator.popFront();
        }

        writeln("\nTesting HashMap byKey2...");
        foreach (int key; hmap.byKey)
        {
            writeln("Key is: " ~ key.to!string());
        }

        writeln("\nTesting HashMap byKey3...");
        foreach (size_t index, int key; hmap.byKey)
        {
            writefln("Key[%d] is: %d ", index, key);
        }

        writeln("\nTesting HashMap byValue1...");
        InputRange!string valueIterator = hmap.byValue();
        while (!valueIterator.empty)
        {
            writeln("value is: " ~ valueIterator.front.to!string());
            valueIterator.popFront();
        }

        writeln("\nTesting HashMap byValue2...");
        foreach (string value; hmap.byValue)
        {
            writeln("value is: " ~ value);
        }

        writeln("\nTesting HashMap byValue3...");
        foreach (size_t index, string value; hmap.byValue)
        {
            writefln("value[%d] is: %s ", index, value);
        }

    }

    void testHashMapRemove()
    {
        HashMap!(int, string) hmap = new HashMap!(int, string)();

        //Adding elements to LinkedHashMap
        hmap.put(22, "Abey");
        hmap.put(33, "Dawn");
        hmap.put(1, "Sherry");
        hmap.put(2, "Karon");
        hmap.put(100, "Jim");

        writefln("item[%d]=%s", 33, hmap.get(33));

        writeln(hmap.toString());

        assert(hmap.size() == 5);
        hmap.remove(1);
        
        writeln(hmap.toString());
        assert(hmap.size() == 4);

    }

    void testTreeMap()
    {
        /* This is how to declare TreeMap */
        TreeMap!(int, string) tmap = new TreeMap!(int, string)();

        /*Adding elements to TreeMap*/
        tmap.put(1, "Data1");
        tmap.put(23, "Data23");
        tmap.put(70, "Data70");
        tmap.put(4, "Data4");
        tmap.put(2, "Data2");

        writeln(tmap.toString());
        assert(tmap[70] == "Data70", tmap[70]);

        /* Display content using Iterator*/
        //   Set!(MapEntry!(K,V)) set = tmap.entrySet();
        //   Iterator!(MapEntry!(K,V)) iterator = set.iterator();
        //   while(iterator.hasNext()) {
        //      Map.Entry mentry = (Map.Entry)iterator.next();
        //      System.out.print("key is: "+ mentry.getKey() + " & Value is: ");
        //      writeln(mentry.getValue());
        //   }
        writeln("\nTesting TreeMap foreach1...");
        foreach (int key, string value; tmap)
        {
            writeln("key is: " ~ key.to!string ~ " & Value is: " ~ value);
        }

        writeln("\nTesting TreeMap foreach2...");
        foreach (MapEntry!(int, string) entry; tmap)
        {
            writeln("Key is: " ~ entry.getKey().to!string ~ " & Value is: " ~ entry.getValue());
        }

        writeln("\nTesting TreeMap byKey...");
        foreach (size_t index, int key; tmap.byKey)
        {
            writefln("Key[%d] is: %d ", index, key);
        }

        writeln("\nTesting TreeMap byValue...");
        foreach (size_t index, string value; tmap.byValue)
        {
            writefln("value[%d] is: %s ", index, value);
        }
    }
}