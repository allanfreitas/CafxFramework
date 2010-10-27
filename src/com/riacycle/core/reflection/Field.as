package com.riacycle.core.reflection
{
	import mx.collections.ArrayCollection;

	public class Field
	{
		public var name:String;
		public var type:String;
		public var typeClazz:Class;
		public var annotations:ArrayCollection;
		
		public function getAnnotation(name:String):Annotation{
			for (var i:int=0 ; i < annotations.length ; i++){
				var annotation:Annotation = annotations.getItemAt(i) as Annotation;
				if (annotation.name == name) return annotation;
			}
			return null;
		}
		
	}
}