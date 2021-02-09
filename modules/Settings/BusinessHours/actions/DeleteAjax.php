<?php
/**
 * Settings BusinessHours DeleteAjax class.
 *
 * @package Action
 *
 * @copyright YetiForce Sp. z o.o.
 * @license YetiForce Public License 3.0 (licenses/LicenseEN.txt or yetiforce.com)
 * @author Rafal Pospiech <r.pospiech@yetiforce.com>
 */
class Settings_BusinessHours_DeleteAjax_Action extends Settings_Vtiger_Delete_Action
{
	/**
	 * {@inheritdoc}
	 */
	public function process(App\Request $request)
	{
		$result = ['success' => true];
		$recordModel = Settings_BusinessHours_Record_Model::getInstanceById($request->getInteger('record'));
		if ($recordModel) {
			$result = ['success' => (bool) $recordModel->delete()];
		}
		$response = new Vtiger_Response();
		$response->setResult($result);
		$response->emit();
	}
}
