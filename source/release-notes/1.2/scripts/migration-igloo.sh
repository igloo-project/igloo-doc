#! /bin/bash

## POM renaming
while read line; do
find . -type f -name "pom.xml" -exec sed -i "${line}" {} +
done <<EOF
s@Nexus OWSI Core@Nexus Igloo@g
s@fr\.openwide\.core@org.iglooproject@g
s@owsi-core@igloo@g
s@<version>0\.14@<version>1.0-SNAPSHOT@g
s@<igloo.version>0\.14@<igloo.version>1.0-SNAPSHOT@g
s@projects\.openwide\.fr/services/nexus/content/repositories/igloo-snapshots@nexus.tools.kobalt.fr/repository/igloo-snapshots/@g
s@projects\.openwide\.fr/services/nexus/content/repositories/igloo@nexus.tools.kobalt.fr/repository/igloo/@g
EOF

## Package renaming
find . -type f \( -name "*.xml" -o -name "*.java" -o -name "*.properties" \)  -exec sed -i 's@fr\.openwide\.core@org.iglooproject@g' {} +

## GenericListItem -> GenericBasicReferenceData
while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.jpa.more.business.generic.model.GenericListItem/org.iglooproject.jpa.more.business.referencedata.model.GenericBasicReferenceData/g
s/\\\Qorg.iglooproject.jpa.more.business.generic.query.AbstractGenericListItemHibernateSearchSearchQueryImpl/org.iglooproject.jpa.more.business.referencedata.search.GenericReferenceDataSearchQueryImpl/g
s/\\\QAbstractGenericListItemHibernateSearchSearchQueryImpl/GenericReferenceDataSearchQueryImpl/g
s/\\\Qorg.iglooproject.jpa.more.business.generic.query.IGenericListItemSearchQuery/org.iglooproject.jpa.more.business.referencedata.search.IGenericBasicReferenceDataSearchQuery/g
s/\\\QIGenericListItemSearchQuery/IGenericBasicReferenceDataSearchQuery/g
s/\\\Qorg.iglooproject.jpa.more.business.generic.service.IGenericListItemService/org.iglooproject.jpa.more.business.referencedata.service.IGenericBasicReferenceDataService/g
s/\\\QIGenericListItemService/IGenericBasicReferenceDataService/g
s/\\\Qorg.iglooproject.wicket.more.rendering.GenericListItemRenderer/org.iglooproject.wicket.more.rendering.GenericBasicReferenceDataRenderer/g
s/\\\QGenericListItemRenderer/GenericBasicReferenceDataRenderer/g
s/\\\QGenericListItem/GenericBasicReferenceData/g
EOF

## Class moved
while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.jquery.plugins.bootstrap.confirm.component.AjaxConfirmLink/org.iglooproject.wicket.more.markup.html.template.js.bootstrap.confirm.component.AjaxConfirmLink/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.jquery.plugins.bootstrap.modal.behavior.AjaxModalOpenBehavior/org.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.behavior.AjaxModalOpenBehavior/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.jquery.plugins.bootstrap.modal.component.AbstractAjaxModalPopupPanel/org.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.component.AbstractAjaxModalPopupPanel/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.jquery.plugins.bootstrap.modal.component.DelegatedMarkupPanel/org.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.component.DelegatedMarkupPanel/g
s/\\\Qorg.iglooproject.jpa.more.business.generic.model.EnabledFilter/org.iglooproject.jpa.more.business.generic.model.search.EnabledFilter/g
s/\\\Qorg.iglooproject.spring.config.ExtendedTestApplicationContextInitializer/org.iglooproject.config.bootstrap.spring.ExtendedTestApplicationContextInitializer/g
s/\\\Qorg.retzlaff.select2.Select2Behavior/org.wicketstuff.select2.Select2Behavior/g
s/\\\Qorg.iglooproject.wicket.more.common.WorkInProgressPopup/org.iglooproject.wicket.more.common.component.WorkInProgressPopup/g
EOF

## Various renaming
while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\QOWSI_CORE_VERSION/IGLOO_VERSION/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.action.AbstractAjaxAction/org.iglooproject.wicket.more.markup.html.action.IAjaxAction/g
s/\\\QAbstractAjaxAction/IAjaxAction/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.factory.AbstractDetachableFactory/org.iglooproject.wicket.more.markup.html.factory.IDetachableFactory/g
s/\\\QAbstractDetachableFactory/IDetachableFactory/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.action.AbstractOneParameterAjaxAction/org.iglooproject.wicket.more.markup.html.action.IOneParameterAjaxAction/g
s/\\\QAbstractOneParameterAjaxAction/IOneParameterAjaxAction/g
s/\\\Qorg.iglooproject.jpa.junit.AbstractTestCase/org.iglooproject.test.jpa.junit.AbstractTestCase/g
s/\\\QFormPanelMode/FormMode/g
s/\\\Qorg.apache.wicket.ajax.AjaxRequestTarget.AbstractListener/org.apache.wicket.ajax.AjaxRequestTarget.IListener/g
s/\\\QAbstractListener/IListener/g
s/\\\Qorg.apache.wicket.model.AbstractReadOnlyModel/org.apache.wicket.model.IModel/g
s/\\\QAbstractReadOnlyModel/IModel/g
s/\\\Qorg.retzlaff.select2.Select2Settings/org.wicketstuff.select2.Settings/g
s/\\\QSelect2Settings/Settings/g
s/\\\QfillSettings/fillSelect2Settings/g
EOF

## User modification
while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.jpa.security.service.AuthenticationUserNameComparison/org.iglooproject.jpa.security.service.AuthenticationUsernameComparison/g
s/\\\QAuthenticationUserNameComparison/AuthenticationUsernameComparison/g
s/\\\QauthenticationUserNameComparison/authenticationUsernameComparison/g
s/\\\QsetAuthenticationUserNameComparison/setAuthenticationUsernameComparison/g
s/\\\QgetUserName(/getUsername(/g
s/\\\QgetByUserName(/getByUsername(/g
s/\\\QsetUserName(/setUsername(/g
s/\\\Q.userName(/.username(/g
s/\\\Q.getByUserNameCaseInsensitive(/.getByUsernameCaseInsensitive(/g
s/\\\QLAST_NAME_SORT_FIELD_NAME/LAST_NAME_SORT/g
s/\\\QFIRST_NAME_SORT_FIELD_NAME/FIRST_NAME_SORT/g
s/\\\QUSER_NAME_SORT_FIELD_NAME/USERNAME_SORT/g
EOF

## Migration Bindgen
while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.commons.util.binding.AbstractCoreBinding/org.iglooproject.commons.util.binding.ICoreBinding/g
s/\\\QAbstractCoreBinding/ICoreBinding/g
s/\\\Qorg.bindgen.binding.AbstractBinding/org.bindgen.BindingRoot/g
s/\\\QAbstractBinding/BindingRoot/g
EOF

## Configuration ciManagement
while read line; do
find .  -type f \( -name "*.java" -o -name "web.xml" \) -exec sed -i "${line}" {} \;
done <<EOF
s/org.iglooproject.spring.config.AbstractExtendedApplicationContextInitializer/org.iglooproject.config.bootstrap.spring.AbstractExtendedApplicationContextInitializer/g
s/org.iglooproject.spring.config.annotation.ApplicationConfigurerBeanFactoryPostProcessor/org.iglooproject.config.bootstrap.spring.ApplicationConfigurerBeanFactoryPostProcessor/g
s/org.iglooproject.spring.config.ExtendedApplicationContextInitializer/org.iglooproject.config.bootstrap.spring.ExtendedApplicationContextInitializer/g
s/org.iglooproject.spring.config.spring.annotation.ApplicationDescription/org.iglooproject.config.bootstrap.spring.annotations.ApplicationDescription/g
s/org.iglooproject.spring.config.spring.annotation.ConfigurationLocations/org.iglooproject.config.bootstrap.spring.annotations.ConfigurationLocations/g
EOF

## Property config
find . -type f \( -name "*PropertyRegistryConfig.java" -o -name "*CoreApplicationPropertyConfig.java" \) \
 -exec perl -p -i -e 's/\Qprotected void register(/public void register(/g' {} \;

#! /bin/bash

while read line; do
find -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManager/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManager/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManagerStatement/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManagerStatement/g
s/\\\Qorg.iglooproject.wicket.more.WicketBootstrapPackage/org.iglooproject.wicket.bootstrap3.WicketBootstrapPackage/g
s/\\\Qorg.iglooproject.wicket.more.application.WicketBootstrapModule/org.iglooproject.wicket.bootstrap3.application.WicketBootstrapModule/g
s/\\\Qorg.iglooproject.wicket.more.config.spring.WicketBootstrapServiceConfig/org.iglooproject.wicket.bootstrap3.config.spring.WicketBootstrapServiceConfig/g
s/\\\Qorg.iglooproject.wicket.more.config.spring.AbstractBootstrapWebappConfig/org.iglooproject.wicket.bootstrap3.config.spring.AbstractBootstrapWebappConfig/g
s/\\\Qorg.iglooproject.wicket.more.console.navigation.page.ConsoleSignInPage/org.iglooproject.wicket.bootstrap3.console.navigation.page.ConsoleSignInPage/g
s/\\\Qorg.iglooproject.wicket.more.console.navigation.page.ConsoleAccessDeniedPage/org.iglooproject.wicket.bootstrap3.console.navigation.page.ConsoleAccessDeniedPage/g
s/\\\Qorg.iglooproject.wicket.more.console.navigation.page.ConsoleLoginFailurePage/org.iglooproject.wicket.bootstrap3.console.navigation.page.ConsoleLoginFailurePage/g
s/\\\Qorg.iglooproject.wicket.more.console.navigation.page.ConsoleLoginSuccessPage/org.iglooproject.wicket.bootstrap3.console.navigation.page.ConsoleLoginSuccessPage/g
s/\\\Qorg.iglooproject.wicket.more.console.resources.CoreWicketConsoleResources/org.iglooproject.wicket.bootstrap3.console.resources.CoreWicketConsoleResources/g
s/\\\Qorg.iglooproject.wicket.more.console.common.util.LinkUtils/org.iglooproject.wicket.bootstrap3.console.common.util.LinkUtils/g
s/\\\Qorg.iglooproject.wicket.more.console.common.component.JavaClassesListMultipleChoice/org.iglooproject.wicket.bootstrap3.console.common.component.JavaClassesListMultipleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.common.component.PropertyIdListPanel/org.iglooproject.wicket.bootstrap3.console.common.component.PropertyIdListPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.common.form.PropertyIdEditPopup/org.iglooproject.wicket.bootstrap3.console.common.form.PropertyIdEditPopup/g
s/\\\Qorg.iglooproject.wicket.more.console.template.ConsoleTemplate/org.iglooproject.wicket.bootstrap3.console.template.ConsoleTemplate/g
s/\\\Qorg.iglooproject.wicket.more.console.template.ConsoleConfiguration/org.iglooproject.wicket.bootstrap3.console.template.ConsoleConfiguration/g
s/\\\Qorg.iglooproject.wicket.more.console.template.style.ConsoleLessCssResourceReference/org.iglooproject.wicket.bootstrap3.console.template.style.ConsoleLessCssResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.console.template.style.ConsoleSignInLessCssResourceReference/org.iglooproject.wicket.bootstrap3.console.template.style.ConsoleSignInLessCssResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.console.template.style.CoreConsoleCssScope/org.iglooproject.wicket.bootstrap3.console.template.style.CoreConsoleCssScope/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.ehcache.page.ConsoleMaintenanceEhCachePage/org.iglooproject.wicket.bootstrap3.console.maintenance.ehcache.page.ConsoleMaintenanceEhCachePage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.ehcache.component.EhCacheProgressBarComponent/org.iglooproject.wicket.bootstrap3.console.maintenance.ehcache.component.EhCacheProgressBarComponent/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.ehcache.component.EhCacheCachePortfolioPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.ehcache.component.EhCacheCachePortfolioPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.ehcache.component.EhCacheCacheModificationPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.ehcache.component.EhCacheCacheModificationPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.file.page.ConsoleMaintenanceFilePage/org.iglooproject.wicket.bootstrap3.console.maintenance.file.page.ConsoleMaintenanceFilePage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.search.page.ConsoleMaintenanceSearchPage/org.iglooproject.wicket.bootstrap3.console.maintenance.search.page.ConsoleMaintenanceSearchPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.queuemanager.renderer.QueueTaskRenderer/org.iglooproject.wicket.bootstrap3.console.maintenance.queuemanager.renderer.QueueTaskRenderer/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.queuemanager.renderer.QueueManagerRenderer/org.iglooproject.wicket.bootstrap3.console.maintenance.queuemanager.renderer.QueueManagerRenderer/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.queuemanager.page.ConsoleMaintenanceQueueManagerPage/org.iglooproject.wicket.bootstrap3.console.maintenance.queuemanager.page.ConsoleMaintenanceQueueManagerPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.queuemanager.component.ConsoleMaintenanceQueueManagerNodePanel/org.iglooproject.wicket.bootstrap3.console.maintenance.queuemanager.component.ConsoleMaintenanceQueueManagerNodePanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.authentication.page.ConsoleMaintenanceAuthenticationPage/org.iglooproject.wicket.bootstrap3.console.maintenance.authentication.page.ConsoleMaintenanceAuthenticationPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.renderer.INodeRenderer/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.renderer.INodeRenderer/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.page.ConsoleMaintenanceInfinispanPage/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.page.ConsoleMaintenanceInfinispanPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanNodesPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanNodesPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanLocksPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanLocksPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanRolesPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanRolesPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanRolesRequestsPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanRolesRequestsPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanClusterPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.component.ConsoleMaintenanceInfinispanClusterPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.form.NodeDropDownSingleChoice/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.form.NodeDropDownSingleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.infinispan.form.ConsoleMaintenanceInfinispanRoleAssignPopup/org.iglooproject.wicket.bootstrap3.console.maintenance.infinispan.form.ConsoleMaintenanceInfinispanRoleAssignPopup/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.page.ConsoleMaintenanceTaskDescriptionPage/org.iglooproject.wicket.bootstrap3.console.maintenance.task.page.ConsoleMaintenanceTaskDescriptionPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.page.ConsoleMaintenanceTaskListPage/org.iglooproject.wicket.bootstrap3.console.maintenance.task.page.ConsoleMaintenanceTaskListPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskTypeListMultipleChoice/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskTypeListMultipleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskQueueIdListMultipleChoice/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskQueueIdListMultipleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskStatusPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskStatusPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskExecutionResultPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskExecutionResultPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskResultListMultipleChoice/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskResultListMultipleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskFilterPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskFilterPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskStatusListMultipleChoice/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskStatusListMultipleChoice/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskManagerInformationPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskManagerInformationPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskResultPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskResultPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.task.component.TaskResultsPanel/org.iglooproject.wicket.bootstrap3.console.maintenance.task.component.TaskResultsPanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.gestion.page.ConsoleMaintenanceGestionPage/org.iglooproject.wicket.bootstrap3.console.maintenance.gestion.page.ConsoleMaintenanceGestionPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.upgrade.page.ConsoleMaintenanceDonneesPage/org.iglooproject.wicket.bootstrap3.console.maintenance.upgrade.page.ConsoleMaintenanceDonneesPage/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.upgrade.component.DataUpgradePanel/org.iglooproject.wicket.bootstrap3.console.maintenance.upgrade.component.DataUpgradePanel/g
s/\\\Qorg.iglooproject.wicket.more.console.maintenance.template.ConsoleMaintenanceTemplate/org.iglooproject.wicket.bootstrap3.console.maintenance.template.ConsoleMaintenanceTemplate/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.bootstrap.WicketBootstrapComponentsModule/org.iglooproject.wicket.bootstrap3.markup.html.bootstrap.WicketBootstrapComponentsModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.bootstrap.component.BootstrapLabel/org.iglooproject.wicket.bootstrap3.markup.html.bootstrap.component.BootstrapLabel/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.bootstrap.component.BootstrapBadge/org.iglooproject.wicket.bootstrap3.markup.html.bootstrap.component.BootstrapBadge/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.collapse.BootstrapCollapseJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.collapse.BootstrapCollapseJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.dropdown.BootstrapDropdownModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.dropdown.BootstrapDropdownModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.dropdown.BootstrapDropDownJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.dropdown.BootstrapDropDownJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.confirm.BootstrapConfirmModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.confirm.BootstrapConfirmModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.confirm.BootstrapConfirmJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.confirm.BootstrapConfirmJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.tooltip.BootstrapTooltipModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.tooltip.BootstrapTooltipModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.tooltip.BootstrapTooltipJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.tooltip.BootstrapTooltipJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.popover.BootstrapPopoverJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.popover.BootstrapPopoverJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.popover.BootstrapPopoverModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.popover.BootstrapPopoverModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.alert.BootstrapAlertJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.alert.BootstrapAlertJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.SimpleOptions/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.SimpleOptions/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.affix.BootstrapAffixOptions/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.affix.BootstrapAffixOptions/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.affix.BootstrapAffixBehavior/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.affix.BootstrapAffixBehavior/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.affix.BootstrapAffixJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.affix.BootstrapAffixJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.tab.BootstrapTabModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.tab.BootstrapTabModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.tab.BootstrapTabJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.tab.BootstrapTabJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.BootstrapModalJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.BootstrapModalJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.BootstrapModalModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.BootstrapModalModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManager/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManager/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManagerStatement/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.statement.BootstrapModalManagerStatement/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.modal.BootstrapModalManagerJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.modal.BootstrapModalManagerJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.button.BootstrapButtonJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.button.BootstrapButtonJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.button.BootstrapButtonModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.button.BootstrapButtonModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.scrollspy.BootstrapScrollSpyJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.scrollspy.BootstrapScrollSpyJavaScriptResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.bootstrap.scrollspy.BootstrapScrollSpyModule/org.iglooproject.wicket.bootstrap3.markup.html.template.js.bootstrap.scrollspy.BootstrapScrollSpyModule/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.css.select2.Select2CssResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.css.select2.Select2CssResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.css.bootstrap.fontawesome.CoreFontAwesomeCssScope/org.iglooproject.wicket.bootstrap3.markup.html.template.css.bootstrap.fontawesome.CoreFontAwesome4CssScope/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.css.bootstrap.CoreBootstrap3CssScope/org.iglooproject.wicket.bootstrap3.markup.html.template.css.bootstrap.CoreBootstrap3CssScope/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.css.bootstrap.bootstrap.DefaultBootstrap3LessCssResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.css.bootstrap.bootstrap.DefaultBootstrap3LessCssResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.css.bootstrap.jqueryui.JQueryUiCssResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.css.bootstrap.jqueryui.JQueryUiCssResourceReference/g
s/\\\Qorg.iglooproject.wicket.more.markup.html.template.js.respond.RespondJavaScriptResourceReference/org.iglooproject.wicket.bootstrap3.markup.html.template.js.respond.RespondJavaScriptResourceReference/g
EOF

## CoreFrenchMiniamStem
while read line; do
find \( -name "*.java" -o -name "web.xml" \) -exec perl -p -i -e "${line}" {} +
done <<EOF
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemFilterFactory@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemFilterFactory@g
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemmer@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemmer@g
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemFilter@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemFilter@g
EOF

## SLF4J
while read line; do
find \( -name "*.java" -o -name "web.xml" \) -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.commons.util.logging.SLF4JLoggingListener/org.iglooproject.slf4j.jul.bridge.SLF4JLoggingListener/g
EOF

## Igloo commons split
while read line; do
find -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s@\\\Qorg.iglooproject.commons.util.FileUtils@org.iglooproject.commons.io.FileUtils@g
s@\\\Qorg.iglooproject.commons.util.registry.TFileRegistry@org.iglooproject.truezip.registry.TFileRegistry@g
EOF

## Wicket 8
while read line; do
find -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s@\\\QonError(AjaxRequestTarget target, Form<?> form)@onError(AjaxRequestTarget target)@g
s@\\\QonSubmit(AjaxRequestTarget target, Form<?> form)@onSubmit(AjaxRequestTarget target)@g
s@\\\QonAfterSubmit(AjaxRequestTarget target, Form<?> form)@onAfterSubmit(AjaxRequestTarget target)@g
EOF

## Serializable
while read line; do
find -name '*.java' -exec perl -i -pe "$line" {} ';'
done <<EOF
s/\\\Qorg.iglooproject.commons.util.functional/org.iglooproject.functional/g
s/SerializableFunction(?!2)/SerializableFunction2/g
s/SerializablePredicate(?!2)/SerializablePredicate2/g
s/SerializableSupplier(?!2)/SerializableSupplier2/g
EOF

## Hibernate Search Sort
find . -type f -name "*.java" -exec sed -i 's/analyzer = @Analyzer(definition = HibernateSearchAnalyzer\.TEXT_SORT)/normalizer = @Normalizer(definition = HibernateSearchNormalizer.TEXT)/g' {} +
