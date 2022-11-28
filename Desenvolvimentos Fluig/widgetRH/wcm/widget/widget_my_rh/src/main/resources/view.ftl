<div
	class="widget-my-rh wcm-widget-class super-widget fluig-style-guide"
	id="widgetMyRH_${instanceId}"
	data-params="WidgetMyRH.instance({})"
>
	<div class="card">
		<div class="card-body">
			<div class="row" id="profile-information"></div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12">
					<ul class="nav nav-tabs" role="tablist" id="myTab">
						<li class="active">
							<a href="#point" role="tab" data-toggle="tab">Espelho de ponto</a>
						</li>
						<li>
							<a href="#vacation" role="tab" data-toggle="tab">Férias</a>
						</li>
					</ul>
					<div class="tab-content fs-no-padding-left fs-no-padding-right">
						<div class="tab-pane active" id="point">
							<div class="row fs-md-margin-bottom">
								<div class="col-xs-12 col-sm-12 col-md-4">
									<div class="panel panel-custom">
										<div class="panel-heading">
											<h5 class="fs-no-margin">Saldo anterior</h5>
										</div>
										<div class="panel-body">
											<h2 class="fs-no-margin">+04:45</h2>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-4">
									<div class="panel panel-custom">
										<div class="panel-heading">
											<h5 class="fs-no-margin">Saldo período</h5>
										</div>
										<div class="panel-body">
											<h2 class="fs-no-margin">-03:15</h2>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-4">
									<div class="panel panel-custom">
										<div class="panel-heading">
											<h5 class="fs-no-margin">Total banco</h5>
										</div>
										<div class="panel-body">
											<h2 class="fs-no-margin">+01:30</h2>
										</div>
									</div>
								</div>
							</div>
							<div id="target"></div>
						</div>
						<div class="tab-pane" id="vacation">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="panel panel-custom">
										<div class="panel-heading">
											<h3 class="fs-no-margin">Férias solicitadas</h3>
										</div>
										<div class="panel-body">
											<div class="row">
												<div class="col-xs-12 col-sm-6 col-md-6">
													<h5>Dias de férias</h5>
													<h2>5 dias</h2>
												</div>
												<div class="col-xs-12 col-sm-6 col-md-6">
													<h5>Status</h5>
													<h2>Marcadas</h2>
												</div>
											</div>
											<div class="row">
												<div class="col-xs-12 col-sm-6 col-md-6">
													<h5>Início das férias</h5>
													<h2>27/06/2022</h2>
												</div>
												<div class="col-xs-12 col-sm-6 col-md-6">
													<h5>Final das férias</h5>
													<h2>01/07/2022</h2>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="panel panel-custom" id="vacationDetails">
										<div class="panel-heading">
											<h3 class="fs-no-margin panel-title">
												<a class="collapse-icon" data-toggle="collapse" data-parent="#vacationDetails" href="#collapseDetails">Detalhes das férias</a>
											</h3>
										</div>
										<div id="collapseDetails" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="row">
													<div class="col-xs-12 col-sm-6 col-md-6">
														<h5>Dias</h5>
														<h2>30 dias</h2>
													</div>
													<div class="col-xs-12 col-sm-6 col-md-6">
														<h5>Agendados</h5>
														<h2>5 dias</h2>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-12 col-sm-6 col-md-6">
														<h5>Dias restantes</h5>
														<h2>25 dias</h2>
													</div>
													<div class="col-xs-12 col-sm-6 col-md-6">
														<h5>Agendar até</h5>
														<h2>01/08/2022</h2>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/template" class="template_datatable">
		{{#timenote}}
			<tr>
				<td>{{ date }}</td>
				<td>{{ start }}</td>
				<td>{{ end }}</td>
			</tr>
		{{/timenote}}
	</script>

	<script type="text/template" class="template_profile">
		<div class="col-xs-12 col-sm-4 col-md-3 fs-wrapper-thumbnail fs-md-padding-top">
			<img
				class="fs-display-block fs-margin-auto fs-md-margin-bottom fs-thumbnail"
				src="/collaboration/api/v3/users/{{ alias }}/picture?type=SMALL_PICTURE"
				alt="user photo"
			/>
			<h5 class="fs-text-center">{{ userData.UserSpecialization }}</h5>
			<h6 class="fs-text-center">{{ userData.UserProjects }}</h6>
		</div>
		<div class="col-xs-12 col-sm-8 col-md-9 fs-wrapper-information">
			<h1>{{ name }}</h1>
			<p><i class="flaticon flaticon-email icon-md fs-sm-margin-right" aria-hidden="true"></i>{{ email }}</p>
			<p><i class="flaticon flaticon-phone icon-md fs-sm-margin-right" aria-hidden="true"></i>{{ userData.UserRamal }}</p>
			<p><i class="flaticon flaticon-person-pin-circle icon-md fs-sm-margin-right" aria-hidden="true"></i>São Paulo</p>
		</div>
	</script>
</div>
