package com.riacycle.core.metadata
{
		
	import com.riacycle.core.reflection.Field;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class MetadataField implements IMetadata
	{		
		
		
		
		public function MetadataField()
		{		
						
		}
		
		public function execute(obj:Object,field:Field):void
		{
			var arg:IArgument =  new ArgumentLabel();
			arg.setNext(new ArgumentEnabled());
			arg.execute(obj,field.getAnnotation("Field"));			
			
		}
	}
}