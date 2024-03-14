# Java build tool

This is a somewhat old project (12+ years now in 2024) but it can still be
somewhat useful I think. It started out when I had a Java project that used
[Maven][1] as its build tool. It took around **3 seconds** to compile the entire
project on my laptop, but Maven used around **9 seconds** to report something like this:

*"Nothing to compile - all classes are up to date"*.

So the first version of this build tool was pretty much this:

     javac -d obj -sourcepath src -cp $CLASSPATH $(find src -name '*.java')

But it did evolve a bit, but not much from that first starting point. The
main idea was to make a small build tool that was the direct opposite of Maven.

 * No configuration required
 * Be small (1 file), easy to include with projects
 * Don't use XML for anything
 * Don't do a bunch of stuff the compiler will have to do anyway
 * Don't start with rare time consuming stuff (dependency management)

The Java compiler is also very sophisticated, and does not require a build tool
in the same way other languages need them (compile order or missing dependencies
will be found out by the compiler etc). The Java compiler is also very quick,
so it's often faster to give a problem to the compiler, than to solve it in
other ways.


## Convention

Since it's not configuration based it is of course convention based, and
these are the conventions:


    src       # location of source code
    res       # location of resources (added to jar after build)
    lib       # location of dependencies
    lib/test  # location of test dependencies
    obj       # location of produced class files
    dst       # location of produced jar file
    htm       # location of produced javadoc


[1]: https://maven.apache.org/
