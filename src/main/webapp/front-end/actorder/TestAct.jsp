<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 引入Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>活動介紹頁</title>
</head>
<%@ include file="/front-end/index/guided.jsp"%>
<style>
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/bootstrap.min.css ; media=all */
@media all {
	*, ::after, ::before {
		box-sizing: border-box;
	}
	footer, header, nav {
		display: block;
	}
	body {
		margin: 0;
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
			"Helvetica Neue", Arial, sans-serif, "Apple Color Emoji",
			"Segoe UI Emoji", "Segoe UI Symbol";
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
		color: #212529;
		text-align: left;
		background-color: #fff;
	}
	h1, h2, h3, h4 {
		margin-top: 0;
		margin-bottom: .5rem;
	}
	p {
		margin-top: 0;
		margin-bottom: 1rem;
	}
	ol, ul {
		margin-top: 0;
		margin-bottom: 1rem;
	}
	ol ol, ul ul {
		margin-bottom: 0;
	}
	a {
		color: #007bff;
		text-decoration: none;
		background-color: transparent;
		-webkit-text-decoration-skip: objects;
	}
	a:hover {
		color: #0056b3;
		text-decoration: underline;
	}
	img {
		vertical-align: middle;
		border-style: none;
	}
	button {
		border-radius: 0;
	}
	button:focus {
		outline: 1px dotted;
		outline: 5px auto -webkit-focus-ring-color;
	}
	button, input, textarea {
		margin: 0;
		font-family: inherit;
		font-size: inherit;
		line-height: inherit;
	}
	button, input {
		overflow: visible;
	}
	button {
		text-transform: none;
	}
	button {
		-webkit-appearance: button;
	}
	button::-moz-focus-inner {
		padding: 0;
		border-style: none;
	}
	textarea {
		overflow: auto;
		resize: vertical;
	}
	[type=search] {
		outline-offset: -2px;
		-webkit-appearance: none;
	}
	h1, h2, h3, h4 {
		margin-bottom: .5rem;
		font-family: inherit;
		font-weight: 500;
		line-height: 1.2;
		color: inherit;
	}
	h1 {
		font-size: 2.5rem;
	}
	h2 {
		font-size: 2rem;
	}
	h3 {
		font-size: 1.75rem;
	}
	h4 {
		font-size: 1.5rem;
	}
	.container {
		width: 100%;
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
	}
	@media ( min-width :576px) {
		.container {
			max-width: 540px;
		}
	}
	@media ( min-width :768px) {
		.container {
			max-width: 720px;
		}
	}
	@media ( min-width :992px) {
		.container {
			max-width: 960px;
		}
	}
	@media ( min-width :1200px) {
		.container {
			max-width: 1140px;
		}
	}
	.container-fluid {
		width: 100%;
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
	}
	.row {
		padding-top:50px;
		display: -ms-flexbox;
		display: flex;
		-ms-flex-wrap: wrap;
		flex-wrap: wrap;
		margin-right: -15px;
		margin-left: -15px;
	}
	.col-10, .col-2, .col-lg-10, .col-lg-2, .col-lg-3, .col-lg-5, .col-lg-7,
		.col-md-10, .col-md-12, .col-md-2, .col-md-4, .col-md-6, .col-sm-12,
		.col-sm-3, .col-sm-6, .col-sm-7, .col-xl-10 {
		position: relative;
		width: 100%;
		min-height: 1px;
		padding-right: 15px;
		padding-left: 15px;
	}
	.col-2 {
		-ms-flex: 0 0 16.666667%;
		flex: 0 0 16.666667%;
		max-width: 16.666667%;
	}
	.col-10 {
		-ms-flex: 0 0 83.333333%;
		flex: 0 0 83.333333%;
		max-width: 83.333333%;
	}
	@media ( min-width :576px) {
		.col-sm-3 {
			-ms-flex: 0 0 25%;
			flex: 0 0 25%;
			max-width: 25%;
		}
		.col-sm-6 {
			-ms-flex: 0 0 50%;
			flex: 0 0 50%;
			max-width: 50%;
		}
		.col-sm-7 {
			-ms-flex: 0 0 58.333333%;
			flex: 0 0 58.333333%;
			max-width: 58.333333%;
		}
		.col-sm-12 {
			-ms-flex: 0 0 100%;
			flex: 0 0 100%;
			max-width: 100%;
		}
		.offset-sm-3 {
			margin-left: 25%;
		}
	}
	@media ( min-width :768px) {
		.col-md-2 {
			-ms-flex: 0 0 16.666667%;
			flex: 0 0 16.666667%;
			max-width: 16.666667%;
		}
		.col-md-4 {
			-ms-flex: 0 0 33.333333%;
			flex: 0 0 33.333333%;
			max-width: 33.333333%;
		}
		.col-md-6 {
			-ms-flex: 0 0 50%;
			flex: 0 0 50%;
			max-width: 50%;
		}
		.col-md-10 {
			-ms-flex: 0 0 83.333333%;
			flex: 0 0 83.333333%;
			max-width: 83.333333%;
		}
		.col-md-12 {
			-ms-flex: 0 0 100%;
			flex: 0 0 100%;
			max-width: 100%;
		}
	}
	@media ( min-width :992px) {
		.col-lg-2 {
			-ms-flex: 0 0 16.666667%;
			flex: 0 0 16.666667%;
			max-width: 16.666667%;
		}
		.col-lg-3 {
			-ms-flex: 0 0 25%;
			flex: 0 0 25%;
			max-width: 25%;
		}
		.col-lg-5 {
			-ms-flex: 0 0 41.666667%;
			flex: 0 0 41.666667%;
			max-width: 41.666667%;
		}
		.col-lg-7 {
			-ms-flex: 0 0 58.333333%;
			flex: 0 0 58.333333%;
			max-width: 58.333333%;
		}
		.col-lg-10 {
			-ms-flex: 0 0 83.333333%;
			flex: 0 0 83.333333%;
			max-width: 83.333333%;
		}
	}
	@media ( min-width :1200px) {
		.col-xl-10 {
			-ms-flex: 0 0 83.333333%;
			flex: 0 0 83.333333%;
			max-width: 83.333333%;
		}
	}
	.btn {
		display: inline-block;
		font-weight: 400;
		text-align: center;
		white-space: nowrap;
		vertical-align: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
		border: 1px solid transparent;
		padding: .375rem .75rem;
		font-size: 1rem;
		line-height: 1.5;
		border-radius: .25rem;
		transition: color .15s ease-in-out, background-color .15s ease-in-out,
			border-color .15s ease-in-out, box-shadow .15s ease-in-out;
	}
	@media screen and (prefers-reduced-motion:reduce) {
		.btn {
			transition: none;
		}
	}
	.btn:focus, .btn:hover {
		text-decoration: none;
	}
	.btn:focus {
		outline: 0;
		box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .25);
	}
	.btn:disabled {
		opacity: .65;
	}
	.btn:not(:disabled):not(.disabled) {
		cursor: pointer;
	}
	.btn-dark {
		color: #fff;
		background-color: #343a40;
		border-color: #343a40;
	}
	.btn-dark:hover {
		color: #fff;
		background-color: #23272b;
		border-color: #1d2124;
	}
	.btn-dark:focus {
		box-shadow: 0 0 0 .2rem rgba(52, 58, 64, .5);
	}
	.btn-dark:disabled {
		color: #fff;
		background-color: #343a40;
		border-color: #343a40;
	}
	.fade {
		transition: opacity .15s linear;
	}
	@media screen and (prefers-reduced-motion:reduce) {
		.fade {
			transition: none;
		}
	}
	.fade:not(.show) {
		opacity: 0;
	}
	.nav {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-wrap: wrap;
		flex-wrap: wrap;
		padding-left: 0;
		margin-bottom: 0;
		list-style: none;
	}
	.nav-tabs {
		border-bottom: 1px solid #dee2e6;
	}
	.tab-content>.tab-pane {
		display: none;
	}
	.tab-content>.active {
		display: block;
	}
	.breadcrumb {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-wrap: wrap;
		flex-wrap: wrap;
		padding: .75rem 1rem;
		margin-bottom: 1rem;
		list-style: none;
		background-color: #e9ecef;
		border-radius: .25rem;
	}
	.d-none {
		display: none !important;
	}
	.d-block {
		display: block !important;
	}
	@media ( min-width :768px) {
		.d-md-block {
			display: block !important;
		}
	}
	@media ( min-width :992px) {
		.d-lg-none {
			display: none !important;
		}
		.d-lg-block {
			display: block !important;
		}
	}
	.mt-1 {
		margin-top: .25rem !important;
	}
	.mb-3 {
		margin-bottom: 1rem !important;
	}
	.mb-4 {
		margin-bottom: 1.5rem !important;
	}
	.mt-5 {
		margin-top: 3rem !important;
	}
	.mb-5 {
		margin-bottom: 3rem !important;
	}
	.pl-0 {
		padding-left: 0 !important;
	}
	.text-center {
		text-align: center !important;
	}
	@media print {
		*, ::after, ::before {
			text-shadow: none !important;
			box-shadow: none !important;
		}
		a:not(.btn) {
			text-decoration: underline;
		}
		img {
			page-break-inside: avoid;
		}
		h2, h3, p {
			orphans: 3;
			widows: 3;
		}
		h2, h3 {
			page-break-after: avoid;
		}
		body {
			min-width: 992px !important;
		}
		.container {
			min-width: 992px !important;
		}
	}
}
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/font-awesome.min.css ; media=all */
@media all {
	.fa {
		display: inline-block;
		font: normal normal normal 14px/1 FontAwesome;
		font-size: inherit;
		text-rendering: auto;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
	.fa-twitter:before {
		content: "\f099";
	}
	.fa-facebook:before {
		content: "\f09a";
	}
	.fa-pinterest:before {
		content: "\f0d2";
	}
	.fa-angle-up:before {
		content: "\f106";
	}
	.fa-instagram:before {
		content: "\f16d";
	}
}
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/pe-icon-7-stroke.css ; media=all */
@media all {
	[class^="pe-7s-"], [class*=" pe-7s-"] {
		display: inline-block;
		font-family: 'Pe-icon-7-stroke';
		speak: none;
		font-style: normal;
		font-weight: normal;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
	.pe-7s-map-2:before {
		content: "\e6bb";
	}
	.pe-7s-close:before {
		content: "\e680";
	}
	.pe-7s-search:before {
		content: "\e618";
	}
	.pe-7s-mail-open-file:before {
		content: "\e63b";
	}
	.pe-7s-like:before {
		content: "\e642";
	}
	.pe-7s-cart:before {
		content: "\e66e";
	}
	.pe-7s-call:before {
		content: "\e670";
	}
}
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/magnific-popup.css ; media=all */
@media all {
	button::-moz-focus-inner {
		padding: 0;
		border: 0;
	}
}
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/style.css ; media=all */
@media all {
	.sidr, body {
		overflow-x: hidden;
	}
	a, body {
		color: #222;
	}
	.main-navigation, body, h1, h2, h3, h4 {
		font-family: "Source Sans Pro", Helvetica, Arial, sans-serif;
	}
	.btn:after, body, h1, h2, h3, h4 {
		font-style: normal;
	}
	.btn, .site, .site-branding {
		position: relative;
	}
	#backtotop, .btn {
		text-align: center;
	}
	.btn, .comment-reply-link {
		word-wrap: break-word;
	}
	* {
		padding: 0;
		margin: 0;
	}
	*, :active, :focus, :hover {
		outline: 0 !important;
	}
	body {
		font-weight: 300;
		font-size: 16px;
		line-height: 1.5;
		letter-spacing: .05em;
	}
	.btn, .btn-shop {
		font-size: 12px;
	}
	ol, ul {
		list-style: none;
	}
	a {
		text-decoration: none;
		-webkit-transition: all .1s cubic-bezier(.645, .045, .355, 1);
		transition: all .1s cubic-bezier(.645, .045, .355, 1);
	}
	.btn {
		-webkit-transition: all .2s ease-in-out;
	}
	a:hover {
		text-decoration: none;
		color: #aaa;
	}
	a:focus {
		text-decoration: none;
	}
	p {
		margin-bottom: 8px;
	}
	img {
		max-width: 100%;
		height: auto;
	}
	h1, h2, h3, h4 {
		font-weight: 300;
		line-height: 1.3;
		letter-spacing: .1em;
		color: #111;
		margin-top: 0;
	}
	.btn-shop, .btn:after, input, textarea {
		font-weight: 400;
		display: inline-block;
	}
	input, textarea {
		margin-bottom: 10px;
		padding: 10px 15px;
		max-width: 100%;
		width: 100%;
		border: 1px solid #ddd;
		box-shadow: none;
		color: #888;
		font-size: 12px;
	}
	.btn {
		width: auto;
	}
	input:focus, textarea:focus {
		box-shadow: none !important;
	}
	.btn {
		display: inline-block;
		margin-bottom: 0;
		cursor: pointer;
		color: #5472D2;
		border: 1px solid #fff;
		transition: all .2s ease-in-out;
		line-height: normal;
		padding: 12px 30px;
		letter-spacing: .2em;
		background: 0 0;
	}
	.btn:hover {
		padding-right: 38px;
		padding-left: 22px;
		background-color: #FFF;
	}
	.btn:after {
		visibility: hidden;
		transition: all .2s cubic-bezier(.645, .045, .355, 1);
		content: "\f178";
		color: #222;
		font-family: FontAwesome;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
		opacity: 0;
		margin-left: -18px;
	}
	#side-box-container .widget li a, .btn-shop, .uppercase {
		text-transform: uppercase;
	}
	.btn:hover:after {
		transform: translateX(18px);
		visibility: visible;
		opacity: 1;
	}
	.btn.btn-dark {
		color: #2A2A2A;
		border-color: #2A2A2A;
	}
	.btn.btn-dark:hover {
		color: #fff;
		border-color: #2A2A2A;
		background-color: #2A2A2A;
	}
	.btn.btn-dark:hover:after {
		color: #fff;
	}
	.btn.btn-rounded {
		border-radius: 40px;
	}
	.btn-shop {
		transition: all 10ms cubic-bezier(.645, .045, .355, 1);
		padding: 5px 0 2px;
		border-bottom: 1px solid #444;
		letter-spacing: .3rem;
	}
	.btn-shop:before {
		transition: all .3s cubic-bezier(.645, .045, .355, 1);
	}
	.btn-shop:hover {
		border-color: transparent;
	}
	.btn-shop:before {
		display: inline-block;
		margin-left: -35px;
		padding-right: 5px;
		content: url(http://tk-themes.net/html-heli/demo/images/arrow.svg);
		vertical-align: middle;
		opacity: 0;
	}
	.btn-shop:hover:before {
		margin-left: 0;
		opacity: 1;
	}
	.fullwidth {
		width: 100%;
	}
	.site-branding {
		z-index: 99999;
		padding-left: 15px;
		max-width: 20%;
		-ms-flex-preferred-size: auto;
		flex-basis: auto;
	}
	.search-form-container-full {
		transition: all .3s ease .15s;
		position: fixed;
		top: 0;
		left: 0;
		z-index: 9999999;
		visibility: hidden;
		width: 100%;
		height: 100%;
		opacity: 0;
		-webkit-backface-visibility: hidden;
		backface-visibility: hidden;
		background-color: rgba(0, 0, 0, .85);
		color: #fff;
	}
	.search-form-container-full .search-form {
		transition: all .3s ease .15s;
		position: relative;
		opacity: 0;
		transform: translateY(50px);
	}
	.search-form-container-full .search-form .search-field {
		margin-bottom: 0;
		padding: 17px 0;
		width: 100%;
		border: 0;
		border-bottom: 1px solid #fff;
		background-color: transparent;
		color: #fff;
		font-weight: 300;
		font-size: 26px;
		line-height: 1.2em;
	}
	.search-form-container-full .search-form .button-search {
		position: absolute;
		top: 50%;
		right: 0;
		padding: 0;
		border: 0;
		background-color: transparent;
		transform: translateY(-50%);
	}
	.search-form-container-full .search-form .button-search i {
		font-size: 30px;
		transition: color .2s;
		color: #fff;
		cursor: pointer;
	}
	.search-form-container-full .search-wrap, .search-form-container-full>.container,
		.search-form-container-full>.container>.row {
		height: 100%;
	}
	.search-form-container-full .search-wrap {
		position: relative;
	}
	.search-form-container-full .middle {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 100%;
	}
	.menu-button {
		position: relative;
		width: 20px;
		height: 14px;
		cursor: pointer;
	}
	.sidr {
		position: fixed;
		top: 0;
		z-index: 999999;
		display: block;
		overflow-y: auto;
		width: 350px;
		height: 100%;
	}
	.sidr.right {
		right: -350px;
		left: auto;
	}
	#side-box-container {
		padding: 50px 50px 0;
		width: 350px;
		background-color: #222;
		right: -350px;
		transition: right .2s ease;
	}
	#side-box-container .button-side-box-close {
		margin-left: -18px;
		color: #666;
		font-size: 60px;
		transition: all .3s;
	}
	#side-box-container .button-side-box-close:hover {
		color: #eee;
	}
	#side-box-container .side-box-inner {
		position: absolute;
		top: 170px;
		bottom: 70px;
		left: 0;
		overflow-y: auto;
		padding: 0 50px;
		width: 100%;
	}
	#side-box-container .widget {
		color: #fff;
		font-weight: 300;
	}
	#side-box-container .widget:not(:first-child) {
		margin-top: 100px;
	}
	#side-box-container .widget .widget-title {
		margin-bottom: 17px;
		color: #666;
		text-transform: uppercase;
		font-weight: 400;
		font-size: 13px;
	}
	#side-box-container .widget a {
		color: #fff;
		font-weight: 400;
		font-size: 14px;
	}
	#side-box-container .widget ul {
		margin: 0;
		padding: 0;
		list-style: none;
	}
	#side-box-container .widget li a {
		display: block;
		margin-bottom: 15px;
	}
	#side-box-container .widget li a:hover {
		color: #888;
	}
	#side-box-container .side-box-social-list {
		position: absolute;
		bottom: 50px;
		left: 50px;
		margin: 0;
		padding: 0;
	}
	#side-box-container .side-box-social-list li {
		display: inline-block;
	}
	#side-box-container .side-box-social-list li a {
		margin-right: 15px;
	}
	#side-box-container .side-box-social-list li a i {
		color: #fff;
		transition: color .3s;
		font-size: 16px;
	}
	#side-box-container .side-box-social-list li a:hover i {
		color: #666;
	}
	.header-icon-search {
		display: inline-block;
	}
	.office {
		padding-top: 30px;
	}
	.office p {
		margin-bottom: 10px;
	}
	.office i {
		width: 27px;
		font-size: 20px;
	}
	#backtotop {
		position: fixed;
		right: 20px;
		background: #222;
		width: 40px;
		height: 40px;
		line-height: 40px;
		color: #fff;
		font-size: 15px;
		z-index: 9999;
		-webkit-transition: all .3s linear 0s;
		-khtml-transition: all .3s linear 0s;
		-moz-transition: all .3s linear 0s;
		-ms-transition: all .3s linear 0s;
		-o-transition: all .3s linear 0s;
		transition: all .3s linear 0s;
	}
	.bread_crumb, .bread_crumb a {
		color: #A6A6AC;
	}
	.breadcrumb {
		padding: 0;
		background: 0 0;
		margin-bottom: 3px;
	}
	.bread_crumb {
		position: relative;
		display: inline-block;
		padding: 0;
		margin-bottom: 0;
		margin-left: 3px;
		text-transform: none;
	}
	.comment-content h3, .comment-reply-link, .comment-reply-title,
		.comments-title {
		text-transform: uppercase;
	}
	.bread_crumb li {
		display: inline-block;
		margin-right: 6px;
	}
	.bread_crumb li a:after {
		margin-left: 10px;
		content: '/';
	}
	.comment .comment-author img {
		border-radius: 100%;
		height: auto;
	}
	.comments-title {
		font-weight: 400;
		font-size: 16px;
	}
	.comment-list {
		margin: 0;
		padding: 0;
		list-style: none;
	}
	.comment-list>.comment {
		border-bottom: 1px solid #ddd;
		display: block;
		position: relative;
		float: left;
		width: 100%;
	}
	.comment>div {
		margin-bottom: 20px;
		padding: 20px;
	}
	.comment .comment-author {
		float: left;
		margin-right: 20px;
	}
	.comment .comment-author img {
		max-width: 100%;
	}
	.comment-content {
		padding-left: 120px;
	}
	.comment-content h3 {
		color: #000;
		letter-spacing: .1em;
		font-weight: 400;
		font-style: normal;
		font-size: 14px;
	}
	.comment-list .children {
		margin: 0;
		border-top: 1px solid #ddd;
		list-style: none;
		padding-left: 40px;
	}
	.comment-list .children .comment {
		position: relative;
		float: left;
		width: 100%;
	}
	.comment-reply-link {
		position: absolute;
		top: 20px;
		right: 20px;
		border-bottom: 1px solid #222;
		letter-spacing: .1em;
		font-weight: 400;
		font-size: 12px;
	}
	.comment-respond {
		float: left;
		width: 100%;
	}
	.comment-reply-title {
		margin-top: 30px;
		margin-bottom: 30px;
		font-weight: 400;
		font-size: 16px;
	}
	.comment-form textarea {
		height: 200px;
		resize: vertical;
	}
	.page-open-mobile-menu {
		height: 30px;
		-webkit-box-align: center;
		-webkit-align-items: center;
		-ms-flex-align: center;
		align-items: center;
		display: none;
	}
	.page-open-mobile-menu div {
		position: relative;
		width: 24px;
		height: 18px;
		cursor: pointer;
		margin-top: 6px;
	}
	.page-open-mobile-menu i {
		color: #fff;
		position: absolute;
		top: 50%;
		left: 0;
		margin-top: -1px;
		width: 100%;
		height: 2px;
		background: currentColor;
		-webkit-transition: all .3s cubic-bezier(.645, .045, .355, 1);
		transition: all .3s cubic-bezier(.645, .045, .355, 1);
	}
	.page-open-mobile-menu i::after, .page-open-mobile-menu i::before {
		position: absolute;
		left: 0;
		width: 100%;
		height: 100%;
		background: inherit;
		content: " ";
		-webkit-transition: width .3s cubic-bezier(.645, .045, .355, 1);
		transition: width .3s cubic-bezier(.645, .045, .355, 1);
	}
	.menu-button:after, .menu-button:before {
		content: '';
	}
	.header, .main-navigation .main-menu>li, .main-navigation .main-menu>li .sub-menu a,
		.main-navigation .sub-menu {
		transition: all .5s cubic-bezier(.645, .045, .355, 1);
	}
	.page-open-mobile-menu i:before {
		top: -8px;
	}
	.page-open-mobile-menu i:after {
		top: 8px;
	}
	.page-open-mobile-menu.dark i {
		color: #222;
	}
	.header {
		background-color: rgba(0, 0, 0, 0);
		position: relative;
	}
	.header>.container-fluid>.row>div {
		position: static;
	}
	.menu-button span, .menu-button:after, .menu-button:before {
		position: absolute;
		width: 100%;
		height: 2px;
		background-color: #222;
	}
	.header-column-icon-container {
		text-align: right;
		padding-top: 27px;
	}
	.header-column-icon-container .header-icon {
		float: none;
		margin-top: 0;
		margin-right: 0;
		margin-left: 20px;
		color: #222;
		cursor: pointer;
	}
	.header-column-icon-container .header-icon.header-icon-cart,
		.header-column-icon-container .header-icon.header-icon-search i {
		font-size: 20px;
	}
	.header-column-icon-container .header-icon.header-icon-canvas {
		margin-bottom: 2px;
	}
	.menu-button:before {
		top: 0;
		left: 0;
	}
	.menu-button span {
		margin: auto;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	.menu-button:after {
		bottom: 0;
		left: 0;
	}
	.header-1 .header-column-icon-container {
		padding-right: 70px;
	}
	.main-navigation {
		z-index: 999;
		width: 100%;
		font-weight: 400;
		font-style: normal;
		font-size: 14px;
		line-height: 1.5;
		letter-spacing: .1em;
		position: static;
		max-width: 80%;
		-ms-flex-preferred-size: 80%;
		flex-basis: 80%;
	}
	.main-navigation .main-menu {
		margin-bottom: 0;
	}
	.main-navigation .main-menu>li {
		position: relative;
		display: inline-block;
		padding: 24px 15px;
	}
	.main-navigation .main-menu>li a {
		position: relative;
		z-index: 1;
		text-transform: uppercase;
		color: #222;
	}
	.main-navigation .sub-menu {
		position: absolute;
		top: 120%;
		left: 0;
		z-index: 2;
		visibility: hidden;
		margin: 0;
		padding: 0 0 20px;
		width: 350px;
		border-top: 2px solid #ddd;
		border-bottom: 2px solid #ddd;
		background-color: #f7f7f7;
		opacity: 0;
	}
	.main-navigation .sub-menu li {
		position: relative;
		display: block;
		padding: 20px 40px 0;
		line-height: 1.5;
	}
	.main-navigation .main-menu>li>.sub-menu>li.menu-item-has-children:after
		{
		position: absolute;
		top: 67%;
		right: 20px;
		content: "\e684";
		font-size: 18px;
		font-family: Pe-icon-7-stroke;
		font-style: normal;
		font-weight: 400;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
	}
	.main-navigation .main-menu li:hover>.sub-menu {
		top: 100%;
		z-index: 999;
		visibility: visible;
		opacity: 1;
	}
	.main-navigation .main-menu li>.sub-menu .sub-menu {
		top: 0;
		left: 100%;
	}
	.main-navigation .main-menu>li.mega-menu {
		position: static;
	}
	.main-navigation .main-menu>li.mega-menu .sub-menu {
		width: 100%;
	}
	.main-navigation .main-menu>li.mega-menu>ul>li .column-inner {
		padding: 30px 0;
		width: 100%;
	}
	.main-navigation .main-menu>li .sub-menu a {
		color: #666;
	}
	.main-navigation .main-menu>li.mega-menu>ul>li .mega-menu-content>.row>div:after
		{
		position: absolute;
		top: 0;
		right: 0;
		display: block;
		height: 100%;
		border-right: 1px solid #ddd;
		content: "";
	}
	.main-navigation .main-menu>li.mega-menu>ul>li .mega-menu-content>.row>div:last-child:after
		{
		display: none;
	}
	.main-navigation .main-menu>li .sub-menu a:hover {
		color: #ddd;
		border-bottom: 1px solid #ddd;
	}
	.main-navigation .main-menu>li.mega-menu>ul>li .mega-menu-content .column-inner h4
		{
		padding-left: 20px;
		margin-bottom: 10px;
		color: #222;
		text-transform: uppercase;
		font-size: 16px;
	}
	.main-navigation .main-menu>li.mega-menu ul {
		padding: 0 20px;
	}
	.main-navigation .main-menu>li.mega-menu ul li {
		padding: 10px 0;
	}
	.main-navigation .main-menu>li.mega-menu>ul>li {
		padding: 0;
	}
	.header-1 .main-navigation {
		padding-left: 20px;
	}
	.mobile-menu {
		margin: 0;
		padding: 0;
	}
	.mobile-menu li {
		display: block;
		list-style-type: none;
	}
	.mobile-menu a {
		position: relative;
		display: block;
		font-weight: 400;
		letter-spacing: 0;
		line-height: 1.5;
		text-transform: uppercase;
		font-size: 14px;
	}
	.mobile-menu>li>a {
		padding: 5px 0;
		color: #fff;
	}
	.mobile-menu .toggle-sub-menu {
		position: absolute;
		top: 50%;
		right: 0;
		width: 20px;
		height: 20px;
		background: hsla(0, 0%, 100%, .1);
		color: #fff;
		text-align: center;
		line-height: 20px;
		z-index: 5;
		-webkit-transform: translateY(-50%);
		-ms-transform: translateY(-50%);
		transform: translateY(-50%);
		-webkit-transition: all .3s cubic-bezier(.645, .045, .355, 1);
		transition: all .3s cubic-bezier(.645, .045, .355, 1);
	}
	.section-cover {
		background-repeat: no-repeat;
		background-size: cover;
	}
	.mobile-menu .toggle-sub-menu:after {
		display: block;
		content: "\f105";
		font-size: 12px;
		font-family: FontAwesome;
	}
	.mobile-menu .sub-menu a {
		font-size: 14px;
		color: #fff;
		padding: 8px 0;
	}
	.mobile-menu .sub-menu {
		display: none;
		margin: 12px 0 14px 10px;
	}
	.mobile-menu li a:hover {
		color: #888;
	}
	.section {
		position: relative;
		width: 100%;
		z-index: 1;
	}
	.section-bg-54 {
		background-position: center;
		background-repeat: no-repeat;
	}
	.section-bg-54 {
		background-image:
			url(http://tk-themes.net/html-heli/demo/images/background/bg_56.jpg);
	}
	.footer, .footer .widget-title {
		font-size: 16px;
		line-height: 1.5;
		color: #fff;
		font-style: normal;
	}
	.footer {
		background-color: #222;
		padding: 80px 0;
		font-weight: 300;
		letter-spacing: .05em;
	}
	.footer .widget-title {
		font-weight: 400;
		letter-spacing: .2em;
		padding: 0 0 20px;
	}
	.footer .menu li {
		display: block;
		margin-bottom: 10px;
	}
	.footer a {
		color: #fff;
	}
	.footer a:hover {
		color: #666;
	}
	.copyright, .copyright a {
		color: #222;
	}
	.footer .widget-recent-entries li {
		margin-bottom: 10px;
		padding-bottom: 10px;
		border-bottom: 1px solid #333;
		list-style: none;
	}
	.copyright {
		background-color: #fff;
		padding: 35px 0;
	}
	.page-mobile-main-menu {
		position: fixed;
		top: 0;
		right: 100%;
		z-index: 9999999;
		overflow-x: auto;
		width: 100%;
		height: 100%;
		background: #fff;
		box-shadow: 3px 1px 29px rgba(0, 0, 0, .12);
		text-align: left;
		-webkit-transition: all .3s;
		transition: all .3s;
		background-color: rgba(0, 0, 0, .9);
	}
	.page-mobile-menu-header {
		display: -webkit-box;
		display: -webkit-flex;
		display: -ms-flexbox;
		display: flex;
		padding: 0 30px;
		height: 85px;
		background: #fff;
		-webkit-box-align: center;
		-webkit-align-items: center;
		-ms-flex-align: center;
		align-items: center;
	}
	.page-mobile-menu-logo {
		-webkit-box-flex: 1;
		-webkit-flex-grow: 1;
		-ms-flex-positive: 1;
		flex-grow: 1;
	}
	.page-mobile-menu-logo img {
		width: 60px;
	}
	.page-close-mobile-menu {
		display: -webkit-box;
		display: -webkit-flex;
		display: -ms-flexbox;
		display: flex;
		height: 30px;
		-webkit-box-align: center;
		-webkit-align-items: center;
		-ms-flex-align: center;
		align-items: center;
	}
	.page-close-mobile-menu div {
		position: relative;
		width: 24px;
		height: 18px;
		cursor: pointer;
	}
	.page-close-mobile-menu i {
		position: absolute;
		top: 50%;
		left: 0;
		margin-top: -1px;
		width: 100%;
		height: 2px;
		background: 0 0;
		-webkit-transition: all .3s cubic-bezier(.645, .045, .355, 1);
		transition: all .3s cubic-bezier(.645, .045, .355, 1);
	}
	.page-close-mobile-menu i:after, .page-close-mobile-menu i:before {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: #1a237e;
		content: "";
		-webkit-transition: width .3s cubic-bezier(.645, .045, .355, 1);
		transition: width .3s cubic-bezier(.645, .045, .355, 1);
	}
	.page-close-mobile-menu i:before {
		-webkit-transform: rotate(-45deg);
		-ms-transform: rotate(-45deg);
		transform: rotate(-45deg);
	}
	.page-close-mobile-menu i:after {
		-webkit-transform: rotate(45deg);
		-ms-transform: rotate(45deg);
		transform: rotate(45deg);
	}
	.page-mobile-main-menu .mobile-menu {
		margin: 0;
		padding: 20px 30px 30px;
	}
	.page-mobile-main-menu li {
		display: block;
		list-style-type: none;
	}
	.page-mobile-main-menu .mobile-menu a {
		position: relative;
		display: block;
		font-weight: 400;
		letter-spacing: 0;
		line-height: 1.5;
		text-transform: none;
	}
	.page-mobile-main-menu .mobile-menu>li>a {
		padding: 10px 0;
		border: 0 transparent;
		font-size: 20px;
		color: #fff;
	}
	.page-mobile-main-menu .mobile-menu>li+li>a {
		border-top: 1px solid rgba(255, 255, 255, .1);
	}
	.page-mobile-main-menu .toggle-sub-menu {
		position: absolute;
		top: 50%;
		right: 0;
		width: 40px;
		height: 40px;
		background: hsla(0, 0%, 100%, .1);
		color: #fff;
		text-align: center;
		line-height: 40px;
		z-index: 5;
		-webkit-transform: translateY(-50%);
		-ms-transform: translateY(-50%);
		transform: translateY(-50%);
		-webkit-transition: all .3s cubic-bezier(.645, .045, .355, 1);
		transition: all .3s cubic-bezier(.645, .045, .355, 1);
	}
	.commerce-tabs .tabs>li a, .mini-cart .widget-shopping-cart-content,
		.product-item .extra {
		transition: all .5s cubic-bezier(.645, .045, .355, 1);
	}
	.page-mobile-main-menu .toggle-sub-menu:after {
		display: block;
		content: "\f105";
		font-size: 18px;
		font-family: FontAwesome;
	}
	.page-mobile-main-menu .sub-menu a {
		font-size: 17px;
		color: #fff;
		padding: 8px 0;
	}
	.page-mobile-main-menu .sub-menu {
		display: none;
		margin: 12px 0 14px 10px;
	}
	.star-rating {
		overflow: hidden;
		position: relative;
		height: 1em;
		line-height: 1;
		font-size: 1em;
		width: 5.4em;
		font-family: star;
		color: #222;
	}
	.star-rating::before {
		content: '\73\73\73\73\73';
		color: #d3ced2;
		float: left;
		top: 0;
		left: 0;
		position: absolute;
	}
	.star-rating span {
		overflow: hidden;
		float: left;
		top: 0;
		left: 0;
		position: absolute;
		padding-top: 1.5em;
	}
	.star-rating span::before {
		content: '\53\53\53\53\53';
		top: 0;
		position: absolute;
		left: 0;
	}
	.mini-cart, .mini-cart-icon {
		position: relative;
	}
	.mini-cart {
		display: inline-block;
	}
	.mini-cart .mini-cart__button {
		cursor: pointer;
	}
	.mini-cart .mini-cart__button .mini-cart-icon:before {
		float: none;
		margin: 0;
		width: auto;
		height: auto;
		border: 0;
		content: "\e615";
		font-size: 20px;
		color: #222;
		font-family: Pe-icon-7-stroke;
		font-style: normal;
		font-weight: 400;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
	}
	.mini-cart .mini-cart__button .mini-cart-icon:after {
		position: absolute;
		top: -9px;
		right: -6px;
		min-width: 17px;
		border-radius: 100%;
		content: attr(data-count);
		text-align: center;
		font-size: 11px;
		font-family: inherit;
		line-height: 17px;
		color: #fff;
		background-color: #222;
	}
	.mini-cart .widget-shopping-cart-content {
		position: absolute;
		top: 140%;
		right: 0;
		z-index: 99999;
		visibility: hidden;
		overflow: auto;
		padding-top: 21px;
		max-height: 700px;
		width: 300px;
		background-color: #fff;
		box-shadow: 0 1px 3px rgba(0, 0, 0, .1);
		opacity: 0;
	}
	.mini-cart ul {
		margin: 0;
		padding: 0;
	}
	.mini-cart .cart-list li, .mini-cart .widget-shopping-cart-content .cart-list li
		{
		margin-bottom: 10px;
		padding: 0 15px 10px;
	}
	.mini-cart .cart-list li {
		border-bottom: 1px solid #eee;
		float: left;
		width: 100%;
	}
	.mini-cart .cart-list li.empty {
		border-bottom: none;
	}
	.product-detail span.onsale {
		min-width: 50px;
		min-height: 50px;
		line-height: 50px;
		z-index: 2;
		text-transform: uppercase;
		font-weight: 400;
		text-align: center;
	}
	.product-item {
		position: relative;
		margin-bottom: 30px;
		float: left;
		width: 100%;
	}
	.product-item .thumb {
		position: relative;
		margin-bottom: 30px;
	}
	.product-item a {
		text-decoration: none;
	}
	.product-item a img {
		width: 100%;
		height: auto;
		display: block;
		margin: 0 0 1em;
		box-shadow: none;
	}
	.product-item .extra {
		margin: auto;
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		visibility: hidden;
		border: 1px solid #ddd;
		background-color: rgba(255, 255, 255, .7);
		opacity: 0;
	}
	.product-item:hover .extra {
		visibility: visible;
		opacity: 1;
	}
	.product-item .extra div {
		width: 100%;
		margin: auto;
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		text-align: center;
	}
	.product-item .extra i {
		margin-right: 20px;
		vertical-align: middle;
		font-size: 30px;
	}
	.product-item h3 {
		padding: .5em 0;
		margin: 0;
		font-size: 1em;
		text-transform: uppercase;
		font-weight: 400;
	}
	.product-item .price {
		color: #868686;
		display: block;
		font-weight: 400;
		margin-bottom: .5em;
		font-size: 20px;
	}
	.product-detail span.onsale {
		background-color: #222;
		top: 0;
		left: 0;
		margin: -.5em -.5em 0 0;
		position: absolute;
		border-radius: 100%;
		color: #fff;
		font-size: .857em;
	}
	.product-detail .product-title {
		margin-bottom: 30px;
		text-transform: uppercase;
		font-size: 32px;
	}
	.product-detail .price {
		margin-bottom: 30px;
		color: #222;
		font-weight: 400;
		font-size: 18px;
	}
	.product-detail .price del {
		opacity: .5;
	}
	.product-detail .price ins {
		font-weight: 400;
		text-decoration: none;
	}
	.product-detail p.stock {
		font-size: .92em;
	}
	.product-detail .quantity {
		float: left;
		margin-right: 3px;
	}
	.product-detail .quantity .qty {
		width: 60px;
		text-align: center;
		margin-right: 10px;
		padding: 9px 0 9px 9px;
		border-color: #1f1f1f;
		display: inline-block;
	}
	.product-detail .cart {
		margin-bottom: 40px;
	}
	.product_meta .posted_in, .product_meta .tagged_as {
		display: block;
		text-transform: uppercase;
		letter-spacing: .1em;
		font-weight: 400;
	}
	.product_meta .posted_in a, .product_meta .tagged_as a {
		text-transform: none;
		letter-spacing: normal;
		font-weight: 300;
	}
	.commerce-tabs {
		clear: both;
		width: 100%;
		padding-top: 25px;
		float: left;
	}
	.commerce-tabs .nav-tabs {
		border-bottom: 1px solid #eee;
	}
	.commerce-tabs .tabs>li {
		border: 1px solid #ddd;
		border-bottom: none;
		margin-right: 1px;
	}
	.commerce-tabs .tabs>li a {
		font-size: 80%;
		text-transform: uppercase;
		color: #202020;
		line-height: 44px;
		padding: 0 25px;
		display: block;
		letter-spacing: 2.4px;
		border: none;
		border-radius: 0;
		margin: 0;
	}
	.commerce-tabs .tabs>li a.active, .commerce-tabs .tabs>li:hover a {
		background-color: #222;
		color: #fff;
	}
	.commerce-tabs .tab-content {
		padding: 30px;
		border: 1px solid #ddd;
		border-top: 0;
		margin: 0;
		float: left;
		-webkit-box-shadow: 0 0 0 transparent;
		-khtml-box-shadow: 0 0 0 transparent;
		-moz-box-shadow: 0 0 0 transparent;
		-ms-box-shadow: 0 0 0 transparent;
		-o-box-shadow: 0 0 0 transparent;
		box-shadow: 0 0 0 transparent;
	}
	.related-products h2 {
		margin-bottom: 30px;
		text-transform: uppercase;
		font-weight: 400;
		font-size: 18px;
	}
	@media ( min-width :992px) {
		.header-column-icon-container .header-icon {
			display: inline-block !important;
		}
	}
	@media ( max-width :1280px) and (min-width:1024px) {
		.main-navigation .main-menu>li {
			padding: 27px 10px;
		}
		.main-navigation {
			font-size: 12px;
		}
		.header-1 .header-column-icon-container {
			padding-right: 15px;
		}
	}
	@media ( max-width :1024px) {
		.page-open-mobile-menu {
			display: inline-block;
		}
	}
	@media ( max-width :768px) {
		.header-1 .header-column-icon-container {
			padding-right: 20px;
		}
	}
	@media ( max-width :480px) {
		.quantity .qty {
			max-width: 100%;
		}
		.header-column-icon-container {
			padding-top: 10px;
		}
		.comment-reply-link {
			position: static;
		}
		#main {
			overflow-x: hidden;
		}
	}
}
/*! CSS Used from: http://tk-themes.net/html-heli/demo/css/custom.css ; media=all */
@media all {
	.fz-32 {
		font-size: 32px !important;
	}
	.pt-9 {
		padding-top: 90px !important;
	}
	.pb-6 {
		padding-bottom: 60px !important;
	}
	.pl-0 {
		padding-left: 0px !important;
	}
	.mt-1 {
		margin-top: 10px !important;
	}
	.mt-5 {
		margin-top: 50px !important;
	}
	.mb-3 {
		margin-bottom: 30px !important;
	}
	.mb-4 {
		margin-bottom: 40px !important;
	}
	.mb-5 {
		margin-bottom: 50px !important;
	}
	.mb-6 {
		margin-bottom: 60px !important;
	}
	.white {
		color: #fff !important;
	}
	.dark {
		color: #222 !important;
	}
	@media ( max-width : 480px) {
		.pl-0 {
			padding-left: 15px !important;
		}
	}
}
/*! CSS Used fontfaces */
@font-face {
	font-family: 'FontAwesome';
	src:
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.eot?v=4.6.3');
	src:
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.eot#iefix&v=4.6.3')
		format('embedded-opentype'),
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.woff2?v=4.6.3')
		format('woff2'),
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.woff?v=4.6.3')
		format('woff'),
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.ttf?v=4.6.3')
		format('truetype'),
		url('http://tk-themes.net/html-heli/demo/fonts/fontawesome-webfont.svg?v=4.6.3#fontawesomeregular')
		format('svg');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Pe-icon-7-stroke';
	src:
		url('http://tk-themes.net/html-heli/demo/fonts/Pe-icon-7-stroke.eot?d7yf1v');
	src:
		url('http://tk-themes.net/html-heli/demo/fonts/Pe-icon-7-stroke.eot#iefixd7yf1v')
		format('embedded-opentype'),
		url('http://tk-themes.net/html-heli/demo/fonts/Pe-icon-7-stroke.woff?d7yf1v')
		format('woff'),
		url('http://tk-themes.net/html-heli/demo/fonts/Pe-icon-7-stroke.ttf?d7yf1v')
		format('truetype'),
		url('http://tk-themes.net/html-heli/demo/fonts/Pe-icon-7-stroke.svg?d7yf1v#Pe-icon-7-stroke')
		format('svg');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdh18Smxg.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdo18Smxg.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdg18Smxg.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdv18Smxg.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdj18Smxg.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSdi18Smxg.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight Italic'),
		local('SourceSansPro-ExtraLightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZYokSds18Q.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkidh18Smxg.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkido18Smxg.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkidg18Smxg.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkidv18Smxg.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkidj18Smxg.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkidi18Smxg.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 300;
	src: local('Source Sans Pro Light Italic'),
		local('SourceSansPro-LightItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkids18Q.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7qsDJT9g.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7jsDJT9g.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7rsDJT9g.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7ksDJT9g.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7osDJT9g.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7psDJT9g.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 400;
	src: local('Source Sans Pro Italic'), local('SourceSansPro-Italic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7nsDI.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdh18Smxg.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdo18Smxg.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdg18Smxg.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdv18Smxg.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdj18Smxg.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdi18Smxg.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold Italic'),
		local('SourceSansPro-SemiBoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCds18Q.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdh18Smxg.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdo18Smxg.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdg18Smxg.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdv18Smxg.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdj18Smxg.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSdi18Smxg.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 700;
	src: local('Source Sans Pro Bold Italic'),
		local('SourceSansPro-BoldItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZclSds18Q.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydh18Smxg.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydo18Smxg.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydg18Smxg.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydv18Smxg.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydj18Smxg.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklydi18Smxg.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: italic;
	font-weight: 900;
	src: local('Source Sans Pro Black Italic'),
		local('SourceSansPro-BlackItalic'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZklyds18Q.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wmhduz8A.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wkxduz8A.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wmxduz8A.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wlBduz8A.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wmBduz8A.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wmRduz8A.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 200;
	src: local('Source Sans Pro ExtraLight'),
		local('SourceSansPro-ExtraLight'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wlxdu.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwmhduz8A.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwkxduz8A.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwmxduz8A.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwlBduz8A.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwmBduz8A.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwmRduz8A.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 300;
	src: local('Source Sans Pro Light'), local('SourceSansPro-Light'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwlxdu.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qNa7lqDY.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qPK7lqDY.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qNK7lqDY.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qO67lqDY.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qN67lqDY.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qNq7lqDY.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 400;
	src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xK3dSBYKcSV-LCoeQqfX1RYOo3qOK7l.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwmhduz8A.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwkxduz8A.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwmxduz8A.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwlBduz8A.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwmBduz8A.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwmRduz8A.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 600;
	src: local('Source Sans Pro SemiBold'), local('SourceSansPro-SemiBold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwlxdu.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwmhduz8A.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwkxduz8A.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwmxduz8A.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwlBduz8A.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwmBduz8A.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwmRduz8A.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 700;
	src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3ig4vwlxdu.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwmhduz8A.woff2)
		format('woff2');
	unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF,
		U+A640-A69F, U+FE2E-FE2F;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwkxduz8A.woff2)
		format('woff2');
	unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwmxduz8A.woff2)
		format('woff2');
	unicode-range: U+1F00-1FFF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwlBduz8A.woff2)
		format('woff2');
	unicode-range: U+0370-03FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwmBduz8A.woff2)
		format('woff2');
	unicode-range: U+0102-0103, U+0110-0111, U+1EA0-1EF9, U+20AB;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwmRduz8A.woff2)
		format('woff2');
	unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB,
		U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
	font-family: 'Source Sans Pro';
	font-style: normal;
	font-weight: 900;
	src: local('Source Sans Pro Black'), local('SourceSansPro-Black'),
		url(https://fonts.gstatic.com/s/sourcesanspro/v11/6xKydSBYKcSV-LCoeQqfX1RYOo3iu4nwlxdu.woff2)
		format('woff2');
	unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6,
		U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193,
		U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
	font-family: star;
	src: url(http://tk-themes.net/html-heli/demo/fonts/star.eot);
	src: url(http://tk-themes.net/html-heli/demo/fonts/star.eot#iefix)
		format("embedded-opentype"),
		url(http://tk-themes.net/html-heli/demo/fonts/star.woff)
		format("woff"),
		url(http://tk-themes.net/html-heli/demo/fonts/star.ttf)
		format("truetype"),
		url(http://tk-themes.net/html-heli/demo/fonts/star.svg#star)
		format("svg");
	font-weight: 400;
	font-style: normal;
}
</style>

<body>

	<div class="section product-detail">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<span class="onsale">Sale!</span> <a class="prettyphoto"
						data-rel="prettyPhoto[gallery]" href="images/shop/shop_6.jpg">
						<img
						src="http://tk-themes.net/html-heli/demo/images/shop/shop_detail.jpg"
						alt="" class="fullwidth">
					</a>
				</div>
				<div class="col-sm-6">
					<h1 class="product-title">Leather Jacket</h1>
					<div class="product-rating">
						<div class="star-rating">
							<span style="width: 80%"></span>
						</div>
					</div>
					<div class="price mt-1">
						<del>$20.00</del>
						<ins>$18.00</ins>
					</div>
					<p>Leather jackets look good with anything and everything,
						whether you�re toughening up a floral dress or going for a chic,
						all-black ensemble. Or you can layer it over a plaid shirt and add
						ankle boots for a serious fall vibe, make a light-colored midi
						skirt work for fall by adding a leather jacket and ankle boots.</p>
					<div class="mb-3"></div>
					
					<form class="cart">
				
						<a href="<%=request.getContextPath()%>/front-end/actorder/ActCheckOut.jsp" class="btn btn-rounded btn-dark"><span>預定</span></a>
					</form>
					<div class="product_meta">
						<span class="posted_in">Categories: <a href="#">Bottom</a>,
							<a href="#">Clothing</a></span> <span class="tagged_as">Tags: <a
							href="#">Art</a>, <a href="#">Design</a>, <a href="#">Music</a>,
							<a href="#">Photography</a></span>
					</div>
				</div>
				<div class="col-sm-12">
					<div class="commerce-tabs tabs mt-5 mb-4">
						<!-- Nav tabs -->
						<div class="nav-tabs-wrapper">
							<ul class="nav nav-tabs tabs text-center">
								<li><a class="active" href="#tab-content-1"
									data-toggle="tab">Description</a></li>
								<li><a href="#tab-content-2" data-toggle="tab">Reviews</a>
								</li>
							</ul>
						</div>
						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane active fade show" id="tab-content-1">
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation
									ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation
									ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation
									ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation
									ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
							</div>
							<div class="tab-pane fade" id="tab-content-2">
								<div id="comments" class="comments-area">
									<h2 class="comments-title">4 comments</h2>
									<ol class="comment-list">
										<li class="comment">
											<div class="comment-author vcard">
												<img alt=""
													src="http://tk-themes.net/html-heli/demo/images/avatar/avatar.jpg">
											</div>
											<div class="comment-content">
												<div class="metadata">
													<h3>Meg</h3>
													<a href="#">November 5, 2018</a>
												</div>
												<p>Thank you so much for your article. I am running a
													start-up and really need valuable advice like this. Please
													give more articles on this issues. Thank you!</p>
												<a class="comment-reply-link" href="#">Reply</a>
											</div>
											<ol class="children">
												<li class="comment">
													<div class="comment-author vcard">
														<img alt=""
															src="http://tk-themes.net/html-heli/demo/images/avatar/avatar.jpg">
													</div>
													<div class="comment-content">
														<div class="metadata">
															<h3>Admin</h3>
															<a href="#">November 5, 2018</a>
														</div>
														<p>You�re welcome. I�m glad to help and share my
															opinions.</p>
														<a class="comment-reply-link" href="#">Reply</a>
													</div>
												</li>
											</ol>
										</li>
										<li class="comment">
											<div class="comment-author vcard">
												<img alt=""
													src="http://tk-themes.net/html-heli/demo/images/avatar/avatar.jpg">
											</div>
											<div class="comment-content">
												<div class="metadata">
													<h3>Mark</h3>
													<a href="#">November 5, 2018</a>
												</div>
												<p>This is a very interesting post!</p>
												<a class="comment-reply-link" href="#">Reply</a>
											</div>
										</li>
										<li class="comment">
											<div class="comment-author vcard">
												<img alt=""
													src="http://tk-themes.net/html-heli/demo/images/avatar/avatar.jpg">
											</div>
											<div class="comment-content">
												<div class="metadata">
													<h3>Willis Earnhart</h3>
													<a href="#">November 5, 2018</a>
												</div>
												<p>This is a very interesting post!</p>
												<a class="comment-reply-link" href="#">Reply</a>
											</div>
										</li>
									</ol>
									<!-- .comment-list -->
									<div id="respond" class="comment-respond">
										<h3 class="comment-reply-title">Write a Reply or Comment</h3>
										<form id="commentform" class="comment-form">
											<div class="row">
												<div class="col-md-12">
													<textarea id="comment" placeholder="Comment *"
														name="comment" aria-required="true"></textarea>
												</div>
												<div class="col-md-4">
													<input id="author" placeholder="Name *" name="author"
														type="text" value="" size="30" aria-required="true">
												</div>
												<div class="col-md-4">
													<input id="email" placeholder="Email *" name="email"
														type="text" value="" size="30" aria-required="true">
												</div>
												<div class="col-md-4">
													<input id="url" placeholder="Website" name="url"
														type="text" value="" size="30">
												</div>
												<div class="col-md-12">
													<a href="#" class="btn btn-rounded btn-dark mt-1 mb-5"><span>SUBMIT</span></a>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-12">
					<div class="related-products">
						<h2>Related Products</h2>
						<div class="row">
							<div class="col-sm-3">
								<div class="product-item">
									<div class="thumb">
										<a href="shop-detail.html"> <img
											src="http://tk-themes.net/html-heli/demo/images/shop/shop_1.jpg"
											alt="">
										</a>
										<div class="extra">
											<div>
												<p>
													<i class="pe-7s-cart"></i> <a href="#" class="btn-shop">Add
														to cart</a>
												</p>
												<p>
													<i class="pe-7s-search"></i> <a class="btn-shop"
														href="shop-detail.html">View item</a>
												</p>
											</div>
										</div>
									</div>
									<a href="shop-detail.html"><h3 class="text-center">Basic
											Crop-top</h3></a>
									<div class="info text-center">
										<span class="price">$20.00</span>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="product-item">
									<div class="thumb">
										<a href="shop-detail.html"> <img
											src="http://tk-themes.net/html-heli/demo/images/shop/shop_2.jpg"
											alt="">
										</a>
										<div class="extra">
											<div>
												<p>
													<i class="pe-7s-cart"></i> <a href="#" class="btn-shop">Add
														to cart</a>
												</p>
												<p>
													<i class="pe-7s-search"></i> <a class="btn-shop"
														href="shop-detail.html">View item</a>
												</p>
											</div>
										</div>
									</div>
									<a href="shop-detail.html"><h3 class="text-center">Black
											One-piece</h3></a>
									<div class="info text-center">
										<span class="price">$20.00</span>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="product-item">
									<div class="thumb">
										<a href="shop-detail.html"> <img
											src="http://tk-themes.net/html-heli/demo/images/shop/shop_3.jpg"
											alt="">
										</a>
										<div class="extra">
											<div>
												<p>
													<i class="pe-7s-cart"></i> <a href="#" class="btn-shop">Add
														to cart</a>
												</p>
												<p>
													<i class="pe-7s-search"></i> <a class="btn-shop"
														href="shop-detail.html">View item</a>
												</p>
											</div>
										</div>
									</div>
									<a href="shop-detail.html"><h3 class="text-center">Blue
											dress</h3></a>
									<div class="info text-center">
										<span class="price">$20.00</span>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="product-item">
									<div class="thumb">
										<a href="shop-detail.html"> <img
											src="http://tk-themes.net/html-heli/demo/images/shop/shop_4.jpg"
											alt="">
										</a>
										<div class="extra">
											<div>
												<p>
													<i class="pe-7s-cart"></i> <a href="#" class="btn-shop">Add
														to cart</a>
												</p>
												<p>
													<i class="pe-7s-search"></i> <a class="btn-shop"
														href="shop-detail.html">View item</a>
												</p>
											</div>
										</div>
									</div>
									<a href="shop-detail.html"><h3 class="text-center">Gray
											sweater</h3></a>
									<div class="info text-center">
										<span class="price">$20.00</span>
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


	<!-- LOAD JQUERY LIBRARY -->

	<%@ include file="/front-end/index/footer.jsp"%>

</body>
</html>