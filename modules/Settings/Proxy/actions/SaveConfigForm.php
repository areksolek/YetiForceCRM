<?php
/**
 * Settings proxy save ajax action file.
 *
 * @package   Settings.Action
 *
 * @copyright YetiForce Sp. z o.o
 * @license YetiForce Public License 3.0 (licenses/LicenseEN.txt or yetiforce.com)
 * @author Arkadiusz Sołek <a.solek@yetiforce.com>
 */
/**
 * Settings proxy save ajax action class.
 */
class Settings_Proxy_SaveConfigForm_Action extends Settings_Vtiger_Basic_Action
{
	/** {@inheritdoc} */
	public function process(App\Request $request)
	{
		$response = new Vtiger_Response();
		$qualifiedModuleName = $request->getModule(false);
		$fields = Settings_Proxy_ConfigForm_Model::getFields($qualifiedModuleName);
		$field = $request->getByType('updateField');
		if (!isset($fields[$field])) {
			throw new \App\Exceptions\IllegalValue('ERR_ILLEGAL_VALUE');
		}
		try {
			$fieldModel = $fields[$field];
			$value = $request->getByType($field, $fieldModel->get('purifyType'));
			$configFile = new \App\ConfigFile('security');
			$configFile->set($field, $value);
			$configFile->create();
			$response->setResult(['notify' => ['type' => 'success', 'text' => \App\Language::translate('LBL_CHANGES_SAVED')]]);
		} catch (\Throwable $e) {
			$response->setError(\App\Language::translate('LBL_ERROR', $qualifiedModuleName));
		}
		$response->emit();
	}
}