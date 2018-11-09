LinkDescriptor
==============

.. warning:: Link descriptor early target definition is completely dropped.

* Remove ``IBaseState``, ``IBaseResourceState``, ``IBasePageState``,
  ``IBasePageInstanceState``, ``IBaseImageResourceState``.
  Use late target definition (aka the new and clean way to create link
  descriptor).
* Remove ``IBackwardCompatibleTerminalState``,
  ``IEarlyTargetDefinitionTerminalState``.
  Use late target definition (aka the new and clean way to create link
  descriptor).
* Remove ``AbstractLinkFactory#builder()``.
  Use ``LinkDescriptorBuilder#start()``
  or ``LinkDescriptorBuilder#toPageInstance(Page)``
  or ``LinkDescriptorBuilder#toPageInstance(IModel)`` instead.
* Remove ``org.iglooproject.wicket.more.link.descriptor.mapper.LinkGeneratorFactoryToOneParameterLinkDescriptorMapperAdapter.java``.
* Remove ``org.iglooproject.wicket.more.link.descriptor.factory.LinkGeneratorFactory.java``.
  Instead of extending this class,
  implement ``IOneParameterLinkDescriptorMapper``
  by extending ``AbstractOneParameterLinkDescriptorMapper``
  or build one such object using a ``LinkDescriptorBuilder``.
* Remove ``org.iglooproject.wicket.more.link.descriptor.factory.BindingLinkGeneratorFactory.java``.
  Use ``BindingOneParameterLinkDescriptorMapper`` instead.
* Remove ``ILinkGenerator#INVALID``.
  Use ``LinkDescriptors#invalid()`` instead.
* Remove ``LinkParameterExtractionException#LinkParameterExtractionException(Throwable)``.
  Use ``LinkParameterExtractionException#LinkParameterExtractionException(String, Throwable)`` instead.
* Remove ``LinkParameterInjectionException#LinkParameterInjectionException(Throwable)``.
  Use ``LinkParameterInjectionException#LinkParameterInjectionException(String, Throwable)`` instead.
* Remove ``LinkParameterValidationException#LinkParameterValidationException()``.
  Use ``LinkParameterValidationException#LinkParameterValidationException(String)``
  or ``LinkParameterValidationException#LinkParameterValidationException(String, Throwable)`` instead.
* Remove ``LinkParameterValidationException#LinkParameterValidationException(Throwable)``.
  Use ``LinkParameterValidationException#LinkParameterValidationException(String, Throwable)`` instead.
* Remove ``org.iglooproject.wicket.more.link.descriptor.parameter.validator.PermissionLinkParameterValidator.java``.
  Use ``IValidatorState#permission(IModel, String, String...)`` instead.
* Remove ``org.iglooproject.wicket.more.link.descriptor.parameter.validator.PredicateLinkParameterValidator.java``.
  Use ``IValidatorState#validator(Condition)`` instead.
* Remove ``AbstractDynamicBookmarkableLink#setAutoHideIfInvalid(boolean)``.
  Use ``AbstractDynamicBookmarkableLink#hideIfInvalid()`` instead.
* Remove ``DynamicImage#setAutoHideIfInvalid(boolean)``.
  Use ``DynamicImage#hideIfInvalid()`` instead.
