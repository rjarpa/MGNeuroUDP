patient(1).name='John Doe';
patient(1).billing=127.00;
patient(1).test=[1,2,4;4,5,6.1;220,210,205];
patient

patient = 

  struct with fields:

       name: 'John Doe'
    billing: 127
       test: [3×3 double]

patient(2).name='Ruben';
patient(1).billing=127.00;
patient(2).billing=400;
patient(1).test=[];

patient(1).test=[1,2,4;4,5,6.1;220,210,205];
patient(2).test=[];
patient(3).name='LUZ MAria';
patient(3).test=['aa','bb'];
patient(3).test='aa';
class(patient(3).test)

ans =

    'char'

class(patient(1).test)

ans =

    'double'

class(patient)

ans =

    'struct'

class(patient(1))

ans =

    'struct'

help class
 class  Return class name of object.
    S = class(OBJ) returns the name of the class of object OBJ.
  
    Possibilities are:
      double          -- Double precision floating point number array
                         (this is the traditional MATLAB matrix or array)
      single          -- Single precision floating point number array
      logical         -- Logical array
      char            -- Character array
      cell            -- Cell array
      struct          -- Structure array
      function_handle -- Function Handle
      int8            -- 8-bit signed integer array
      uint8           -- 8-bit unsigned integer array
      int16           -- 16-bit signed integer array
      uint16          -- 16-bit unsigned integer array
      int32           -- 32-bit signed integer array
      uint32          -- 32-bit unsigned integer array
      int64           -- 64-bit signed integer array
      uint64          -- 64-bit unsigned integer array
      <class_name>    -- MATLAB class name for MATLAB objects
      <java_class>    -- Java class name for java objects
 
    %Example 1: Obtain the name of the class of value pi
    name = class(pi);
 
    %Example 2: Obtain the full name of a package-based java class
    obj = java.lang.String('mystring');
    class(obj)
 
    For classes created without a classdef statement (pre-MATLAB version
    7.6 syntax), class invoked within a constructor method creates an
    object of type 'class_name'.  Constructor methods are functions saved
    in a file named <class_name>.m and placed in a directory named
    @<class_name>.  Note that 'class_name' must be the second argument to
    class.  Uses of class for this purpose are shown below.
 
    O = class(S,'class_name') creates an object of class 'class_name'
    from the structure S.
 
    O = class(S,'class_name',PARENT1,PARENT2,...) also inherits the
    methods and fields of the parent objects PARENT1, PARENT2, ...
 
    O = class(struct([]),'class_name',PARENT1,PARENT2,...), specifying
    an empty structure S, creates an object that inherits the methods and
    fields from one or more parent classes, but does not have any 
    additional fields beyond those inherited from the parents.
 
    See also isa, classdef, struct, superiorto, inferiorto.

    Documentation for class
    Other functions named class

--- help for struct ---

 struct Create or convert to structure array.
    S = struct('field1',VALUES1,'field2',VALUES2,...) creates a
    structure array with the specified fields and values.  The value
    arrays VALUES1, VALUES2, etc. must be cell arrays of the same
    size, scalar cells or single values.  Corresponding elements of the
    value arrays are placed into corresponding structure array elements.
    The size of the resulting structure is the same size as the value
    cell arrays or 1-by-1 if none of the values is a cell.
 
    struct(OBJ) converts the object OBJ into its equivalent
    structure.  The class information is lost.
 
    struct([]) creates an empty 0-by-0 structure with no fields.
 
    To create fields that contain cell arrays, place the cell arrays
    within a VALUE cell array.  For instance,
      s = struct('strings',{{'hello','yes'}},'lengths',[5 3])
    creates the 1-by-1 structure
       s = 
          strings: {'hello'  'yes'}
          lengths: [5 3]
 
    Example
       s = struct('type',{'big','little'},'color','red','x',{3 4})
 
    See also isstruct, setfield, getfield, fieldnames, orderfields, 
    isfield, rmfield, deal, substruct, struct2cell, cell2struct.

    Documentation for struct

doc struct
patient(4).nuevo='aa';
patient(4).name=2;
patient(4).name='Cristobal';
todos(1).patient=patient;
todos(1).name='Embarazadas';