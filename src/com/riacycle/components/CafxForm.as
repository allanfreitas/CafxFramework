package com.riacycle.components
{
	import com.riacycle.core.reflection.Annotation;
	import com.riacycle.core.reflection.AnnotationMap;
	import com.riacycle.core.reflection.Clazz;
	import com.riacycle.core.reflection.Field;
	import com.riacycle.core.strategy.FormItemStrategy;
	import com.riacycle.core.reflection.ReflectionAS3Commons;
	import com.riacycle.core.reflection.ReflectionGateway;
	import com.riacycle.core.strategy.UIContext;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.controls.DateField;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.TextInput;
	
	[Event(name="formAction", type="flash.events.Event")]
	public class CafxForm extends Form
	{
		
		[Bindable]
		private var _dynamicDataProvider:Array;
		
		[Bindable]
		private var _objectGenerator:Object;		
		
		private var reflection:ReflectionGateway;
		
		[Bindable]
		public var context:UIContext;
		
		public function CafxForm()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE,onFormGenerator);
			reflection = new ReflectionAS3Commons();
			if (context == null ) context = new UIContext(new FormItemStrategy()); 
		}
		
		public function get dynamicDataProvider():Array
		{
			return _dynamicDataProvider;
		}

		public function set dynamicDataProvider(value:Array):void
		{
			_dynamicDataProvider = value;			
		}

		private function onFormGenerator(event:FlexEvent):void{
			gerenateFields();
			gerenateAction();
		}
		
		private function gerenateFields():void{
			
			var clazz:Clazz = reflection.getClazz(objectGenerator);			
			
			/*inica do 1 por causa do reflect do as3commons retornar no primeiro registro do 
			array um accessor prototype*/			
			for(var i:int=1; i < clazz.fields.length; i++){
				
				var field:Field = clazz.fields.getItemAt(i) as Field;				
				var component:UIComponent = context.executeStrategy(objectGenerator,dynamicDataProvider,field);				
				this.addChild(component);
				
			}
			
			
		}		
		
		private function gerenateAction():void{
			var formItem:FormItem = new FormItem();
			var button:Button = new Button();
			button.label="Salvar";
			button.addEventListener(MouseEvent.CLICK,onSend);
			formItem.addChild(button);
			this.addChild(formItem);
		}
		
		private function onSend(event:MouseEvent):void{
			dispatchEvent(new Event("formAction"));
		}
		
		public function get objectGenerator():Object
		{
			return _objectGenerator;
		}

		public function set objectGenerator(value:Object):void
		{
			_objectGenerator = value;
		}

	}
}