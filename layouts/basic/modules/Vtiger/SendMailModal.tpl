{*<!-- {[The file is published on the basis of YetiForce Public License 3.0 that can be found in the following directory: licenses/LicenseEN.txt or yetiforce.com]} -->*}
{strip}
	{assign var=DEFAULT_SMTP value=App\Mail::getDefaultSmtp()}
	{assign var=TEMPLETE_LIST value=App\Mail::getTemplateList($TEMPLATE_MODULE)}
	{assign var=IS_EMAIL value=false}
	<div class="modal-header align-items-center">
		<h5 class="modal-title"><span class="fas fa-envelope mr-2"></span>{\App\Language::translate('LBL_MASS_SEND_EMAIL', $MODULE)}</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="{\App\Language::translate('LBL_CLOSE')}">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body">
		<div class="alert alert-info" role="alert">
			<span class="fas fa-info-circle"></span>&nbsp;&nbsp;
			{\App\Language::translate('LBL_MASS_SEND_EMAIL_INFO', $MODULE)}
		</div>
		<form class="form-horizontal validateForm">
			<div class="form-group form-row">
				<label class="col-sm-7 col-form-label">
					{\App\Language::translate('LBL_NUMBER_OF_SELECTED_RECORDS', $MODULE)}:
				</label>
				<div class="col-sm-5">
					<p class="form-control-plaintext">{$RECORDS['all']}</p>
				</div>
			</div>
			<div class="form-group form-row">
				<label class="col-sm-7 col-form-label">
					{\App\Language::translate('LBL_NUMBER_OF_FOUND_MAIL_ADDRESSES', $MODULE)}:
				</label>
				<div class="col-sm-5">
					<div class="form-control-plaintext">{$RECORDS['emails']}</div>
				</div>
			</div>
			<div class="form-group form-row">
				<label class="col-sm-7 col-form-label">
					{\App\Language::translate('LBL_NUMBER_OF_FOUND_DUPLICATE_MAIL', $MODULE)}:
				</label>
				<div class="col-sm-5">
					<div class="form-control-plaintext">{$RECORDS['duplicate']}</div>
				</div>
			</div>
			<div class="form-group form-row">
				<label class="col-sm-4 col-form-label">{\App\Language::translate('LBL_EMAIL_ADRESS')}</label>
				<div class="col-sm-8">
					<select class="select2" id="field" data-validation-engine="validate[required]">
						{foreach item=COUNT key=NAME from=$RECORDS}
							{if $NAME != 'all' && $NAME != 'emails'&& $NAME != 'duplicate' && $COUNT > 0}
								<option value="{$FIELDS[$NAME]->getName()}">{\App\Language::translate($FIELDS[$NAME]->getFieldLabel(), $MODULE)}
									({$COUNT})
								</option>
								{assign var=IS_EMAIL value=true}
							{/if}
						{/foreach}
					</select>
				</div>
			</div>
			<div class="form-group form-row">
				<label class="col-sm-4 col-form-label">{\App\Language::translate('LBL_EMAIL_TEMPLATE')}</label>
				<div class="col-sm-8">
					<select class="select2" id="template" data-validation-engine="validate[required]">
						{foreach item=ROW from=$TEMPLETE_LIST}
							<option value="{$ROW['id']}">{$ROW['name']}</option>
						{/foreach}
					</select>
				</div>
			</div>
			<div class="form-group form-row">
				<label class="col-sm-4 col-form-label">{\App\Language::translate('LBL_MASS_MAIL_NOTES')}
					<span class="js-popover-tooltip ml-1" data-toggle="popover"
						data-placement="top"
						data-content="{\App\Language::translate('LBL_MASS_MAIL_NOTES_INFO')}" data-js="popover">
						<span class="fas fa-info-circle"></span>
					</span>
				</label>
				<div class="col-sm-8">
					<textarea class="form-control js-editor" name="mail_notes" id="mail_notes" data-js="ckeditor"></textarea>
				</div>
			</div>
		</form>
		{if !$DEFAULT_SMTP}
			<div class="alert alert-danger" role="alert">
				<span class="fas fa-exclamation-circle"></span>&nbsp;&nbsp;
				{\App\Language::translate('ERR_NO_DEFAULT_SMTP')}
			</div>
		{/if}
	</div>
	<div class="modal-footer">
		{if $DEFAULT_SMTP && $TEMPLETE_LIST && $IS_EMAIL}
			<button class="btn btn-success" type="submit" name="saveButton">
				<span class="fas fa-check mr-1"></span>
				<strong>{\App\Language::translate('LBL_SEND')}</strong>
			</button>
		{/if}
		<button class="btn btn-danger" type="reset" data-dismiss="modal">
			<span class="fas fa-times mr-1"></span>
			<strong>{\App\Language::translate('LBL_CANCEL')}</strong>
		</button>
	</div>
{/strip}
