package com.riacycle.core.strategy
{
	import com.riacycle.core.metadata.IMetadata;
	import com.riacycle.core.metadata.MetadataField;
	import com.riacycle.core.reflection.Annotation;
	import com.riacycle.core.reflection.AnnotationMap;
	import com.riacycle.core.reflection.Field;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.FormItem;
	import mx.controls.DateField;
	import mx.core.UIComponent;
	
	import spark.components.ComboBox;
	import spark.components.TextInput;
	
	public class FormItemStrategy implements UIStrategy
	{		
		
		private var metadatas:Array = new Array();
		
		public function FormItemStrategy(){
			metadatas.push(new MetadataField());
		} 
		
		public function executeStragegy(obj:Object, dataProviders:Array, field:Field):UIComponent
		{
			
			var annotation:Annotation = field.getAnnotation("Field");				
			
			var argLabel:AnnotationMap;
			var argEnabled:AnnotationMap;
			var argComponent:AnnotationMap;
			var argDataProviderIndex:AnnotationMap;
			var argLabelField:AnnotationMap;
			if (annotation != null){
				argLabel = annotation.getAnnotationMap("label");
				argEnabled = annotation.getAnnotationMap("enabled");
				argComponent = annotation.getAnnotationMap("component");
				argDataProviderIndex= annotation.getAnnotationMap("dataprovider");
				argLabelField = annotation.getAnnotationMap("labelField");
			}
			
			var formItem:FormItem = new FormItem();
			for (var i:int=0 ; i < metadatas.length ; i++){
				var metadata:IMetadata = metadatas[i] as IMetadata;
				metadata.execute(formItem,field);
			}			
			
			/*formItem.label = argLabel != null ? argLabel.value.toString() : field.name;
			formItem.enabled = argEnabled != null ? argEnabled.value as Boolean : true;*/
			
			switch (field.type){
				case "String":
					var textinput:TextInput = new TextInput();
					BindingUtils.bindProperty(textinput,"text",obj,field.name);
					BindingUtils.bindProperty(obj,field.name,textinput,"text");
					
					formItem.addChild(textinput);
					break;
				case "Number":
					var textinput:TextInput = new TextInput();
					BindingUtils.bindProperty(textinput,"text",obj,field.name);
					BindingUtils.bindProperty(obj,field.name,textinput,"text");
					
					formItem.addChild(textinput);
					break;
				case "Date":
					var dateField:DateField = new DateField();
					BindingUtils.bindProperty(dateField,"selectedDate",obj,field.name);
					BindingUtils.bindProperty(obj,field.name,dateField,"selectedDate");						
					formItem.addChild(dateField);
					break;
				default:
					if (argComponent != null && argComponent.value=="ComboBox"){
						var combo:ComboBox = new ComboBox();
						combo.dataProvider = getDataProvider(field.typeClazz,dataProviders);
						combo.labelField= argLabelField.value.toString();							
						BindingUtils.bindProperty(combo,"selectedItem",obj,field.name);
						BindingUtils.bindProperty(obj,field.name,combo,"selectedItem");						
						formItem.addChild(combo);	
					}						
					break;
			}
			return formItem;
		}
		
		private function getDataProvider(clazz:Class, dataProviders:Array):ArrayCollection{
			for (var i:int=0 ; i <  dataProviders.length ; i++){
				var collection:ArrayCollection = dataProviders[i] as ArrayCollection ;
				var obj:Object = collection.length > 0 ? collection.getItemAt(0) as Object :null;
				if  ( obj != null ) if (obj is clazz) return collection;
			}
			return null;
		}
		
	}
}