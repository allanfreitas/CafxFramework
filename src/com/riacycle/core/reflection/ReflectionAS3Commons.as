package com.riacycle.core.reflection
{
	import mx.collections.ArrayCollection;
	
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.MetaData;
	import org.as3commons.reflect.MetaDataArgument;
	import org.as3commons.reflect.Type;

	public class ReflectionAS3Commons implements ReflectionGateway
	{
	
		private function getType(obj:Object):Type{
			return Type.forInstance(obj);
		}
		
		public function getClazz(obj:Object):Clazz
		{
			var type:Type = getType(obj);
			
			var clazz:Clazz = new Clazz();
			clazz.name = type.name;
			clazz.fields = getFields(obj);
			
			return clazz;
		}

		public function getFields(obj:Object):ArrayCollection
		{
			
			var fields:ArrayCollection = new ArrayCollection();
			
			var accessors:Array = getType(obj).accessors;
			
			for (var i:int=0; i <  accessors.length ; i++){
				var accessor:Accessor = accessors[i] as  Accessor;
				
				var field:Field = new Field();
				field.name = accessor.name;
				field.type = accessor.type.name;
				field.typeClazz = accessor.type.clazz;
				field.annotations = getAnnotations(obj,accessor.name); 
				fields.addItem(field);
			}
			
			return fields;		
			
		}

		public function getAnnotations(obj:Object, field:String):ArrayCollection
		{
			
			var annotations:ArrayCollection = new ArrayCollection();
			
			var containers:Array = getType(obj).getField(field).metaData;
			
			for (var i:int=0; i <  containers.length ; i++){
				var metadata:MetaData = containers[i] as  MetaData;
				
				var annotation:Annotation = new Annotation();
				annotation.name = metadata.name;
				annotation.maps = getAnnotationMaps(obj,field,metadata.name);				 
				annotations.addItem(annotation);
			}
			
			return annotations;
		}

		public function getAnnotationMaps(obj:Object, field:String, key:String):ArrayCollection
		{
			var annotationsMaps:ArrayCollection = new ArrayCollection();
			
			var args:Array = getType(obj).getField(field).getMetaData(key);
			var metadata:MetaData;
			if (args != null)
				metadata = args[0] as  MetaData;
			
			for (var i:int=0; i <  metadata.arguments.length ; i++){				
				var metaargs:MetaDataArgument = metadata.arguments[i] as  MetaDataArgument;
				
				var map:AnnotationMap = new AnnotationMap();
				map.key = metaargs.key;
				map.value = metaargs.value;								 
				annotationsMaps.addItem(map);
			}
			
			return annotationsMaps;
		}
	}
}